import cx_Oracle
import pandas as pd
import logging

logging.basicConfig(filename='/Landis/ConsultaEndpoint/retorno.log', level=logging.DEBUG,
                    format='%(asctime)s:%(levelname)s:%(message)s')

cx_Oracle.init_oracle_client("/opt/oracle/instantclient_21_9")

def conectar_bd():
    try:
        con_info = {
            'host': 'PSMGV2-BE-SCAN.grupolight.local',
            'port': 1521,
            'user': 'CCBIUSER',
            'psw': 'Light#01',
            'service': 'PRDSMG'
        }

        conn_str = '{user}/{psw}@{host}:{port}/{service}'.format(**con_info)

        conn = cx_Oracle.connect(conn_str)
        return conn
    except Exception as e:
        logging.error(f'Erro ao conectar ao banco de dados: {e}')
        raise

def executar_consulta(conn):
    try:
        with open("/Landis/ConsultaEndpoint/consulta_endpoint.sql", errors='ignore') as sql:
            query = sql.read()

        df = pd.read_sql_query(query, conn)

        logging.info(f'Consulta executada com sucesso. Resultado: \n{df.head()}')
        
        return df
    except Exception as e:
        logging.error(f'Erro ao executar consulta: {e}')
        raise
    finally:
        conn.close()

if __name__ == '__main__':
    try:
        conn = conectar_bd()
        df = executar_consulta(conn)
        arquivo_saida = '/Landis/ConsultaEndpoint/endpoints.csv'
        df.to_csv(arquivo_saida, index=False, sep=',', header=True)
        logging.info(f'Arquivo {arquivo_saida} salvo com sucesso.')
    except Exception as e:
        logging.error(f'Ocorreu um erro: {e}')

