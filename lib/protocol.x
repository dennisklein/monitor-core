#define UDP_HEADER_SIZE 28

enum Ganglia_value_types {
  GANGLIA_VALUE_UNKNOWN,
  GANGLIA_VALUE_STRING, 
  GANGLIA_VALUE_UNSIGNED_SHORT,
  GANGLIA_VALUE_SHORT,
  GANGLIA_VALUE_UNSIGNED_INT,
  GANGLIA_VALUE_INT,
  GANGLIA_VALUE_FLOAT,
  GANGLIA_VALUE_DOUBLE
};

struct Ganglia_gmetric_message {
  string type<>;
  string name<>;
  string values<>;
  string units<>;
  unsigned int slope;
  unsigned int tmax;
  unsigned int dmax;
};

enum Ganglia_message_formats {
   metric_user_defined = 0, /* gmetric message */
   metric_cpu_num,
   metric_cpu_speed,
   metric_mem_total,
   metric_swap_total,
   metric_boottime,
   metric_sys_clock,
   metric_machine_type,
   metric_os_name,
   metric_os_release,
   metric_cpu_user,
   metric_cpu_nice,
   metric_cpu_system,
   metric_cpu_idle,
   metric_cpu_aidle,
   metric_load_one,
   metric_load_five,
   metric_load_fifteen,
   metric_proc_run,
   metric_proc_total,
   metric_mem_free,
   metric_mem_shared,
   metric_mem_buffers,
   metric_mem_cached,
   metric_swap_free,
   metric_gexec,
   metric_heartbeat,
   metric_mtu,
   metric_location,
   metric_bytes_out,
   metric_bytes_in,
   metric_pkts_in,
   metric_pkts_out,
   metric_disk_total,
   metric_disk_free,
   metric_part_max_used,
   GANGLIA_NUM_25_METRICS /* this should always directly follow the last 25 metric_* */
};

union Ganglia_message switch (Ganglia_message_formats id) {
  case metric_user_defined:
    Ganglia_gmetric_message gmetric;

  case metric_cpu_num:       /* xdr_u_short */
    unsigned short u_short;

  case metric_cpu_speed:     /* xdr_u_int */
  case metric_mem_total:     /* xdr_u_int */
  case metric_swap_total:    /* xdr_u_int */
  case metric_boottime:      /* xdr_u_int */
  case metric_sys_clock:     /* xdr_u_int */
  case metric_proc_run:      /* xdr_u_int */
  case metric_proc_total:    /* xdr_u_int */
  case metric_mem_free:      /* xdr_u_int */
  case metric_mem_shared:    /* xdr_u_int */
  case metric_mem_buffers:   /* xdr_u_int */
  case metric_mem_cached:    /* xdr_u_int */
  case metric_swap_free:     /* xdr_u_int */
  case metric_heartbeat:     /* xdr_u_int */
  case metric_mtu:           /* xdr_u_int */
    unsigned int u_int;  

  case metric_machine_type:  /* xdr_string */
  case metric_os_name:       /* xdr_string */
  case metric_os_release:    /* xdr_string */
  case metric_gexec:         /* xdr_string */
  case metric_location:      /* xdr_string */
    string str<>;

  case metric_cpu_user:      /* xdr_float */
  case metric_cpu_nice:      /* xdr_float */
  case metric_cpu_system:    /* xdr_float */
  case metric_cpu_idle:      /* xdr_float */
  case metric_cpu_aidle:     /* xdr_float */
  case metric_load_one:      /* xdr_float */
  case metric_load_five:     /* xdr_float */
  case metric_load_fifteen:  /* xdr_float */
  case metric_bytes_in:      /* xdr_float */
  case metric_bytes_out:     /* xdr_float */
  case metric_pkts_in:       /* xdr_float */
  case metric_pkts_out:      /* xdr_float */
  case metric_part_max_used: /* xdr_float */
    float f;

  case metric_disk_total:    /* xdr_double */
  case metric_disk_free:     /* xdr_double */
    double d;

  default:
    void;
};

struct Ganglia_25metric
{
   int key;
   string name<16>;
   int tmax;
   Ganglia_value_types type;
   string units<32>;
   string slope<32>;
   string fmt<32>;
   int msg_size;
};

#ifdef RPC_HDR
% Ganglia_25metric *Ganglia_25metric_bykey( int key );
% Ganglia_25metric *Ganglia_25metric_byname( char *name );
#endif

#ifdef RPC_XDR
% Ganglia_25metric ganglia_25_metric_array[GANGLIA_NUM_25_METRICS] = {
%  {metric_user_defined, "gmetric",       0,  GANGLIA_VALUE_UNKNOWN,  "", "", 0  },
%  {metric_cpu_num,      "cpu_num",    1200,  GANGLIA_VALUE_UNSIGNED_SHORT, "CPUs",       "zero",  "%hu", UDP_HEADER_SIZE+8},
%  {metric_cpu_speed,    "cpu_speed",  1200,  GANGLIA_VALUE_UNSIGNED_INT,   "MHz",        "zero",  "%hu", UDP_HEADER_SIZE+8},
%  {metric_mem_total,    "mem_total",  1200,  GANGLIA_VALUE_UNSIGNED_INT,   "KB",         "zero",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_swap_total,   "swap_total", 1200,  GANGLIA_VALUE_UNSIGNED_INT,   "KB",         "zero",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_boottime,     "boottime",   1200,  GANGLIA_VALUE_UNSIGNED_INT,   "s",          "zero",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_sys_clock,    "sys_clock",  1200,  GANGLIA_VALUE_UNSIGNED_INT,   "s",          "zero",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_machine_type, "machine_type",1200, GANGLIA_VALUE_STRING,         "",           "zero",  "%s",  UDP_HEADER_SIZE+32},
%  {metric_os_name,      "os_name",    1200,  GANGLIA_VALUE_STRING,         "",           "zero",  "%s",  UDP_HEADER_SIZE+32},
%  {metric_os_release,   "os_release", 1200,  GANGLIA_VALUE_STRING,         "",           "zero",  "%s",  UDP_HEADER_SIZE+32},
%  {metric_cpu_user,     "cpu_user",     90,  GANGLIA_VALUE_FLOAT,          "%",          "both",  "%.1f",UDP_HEADER_SIZE+8},
%  {metric_cpu_nice,     "cpu_nice",     90,  GANGLIA_VALUE_FLOAT,          "%",          "both",  "%.1f",UDP_HEADER_SIZE+8},
%  {metric_cpu_system,   "cpu_system",   90,  GANGLIA_VALUE_FLOAT,          "%",          "both",  "%.1f",UDP_HEADER_SIZE+8},
%  {metric_cpu_idle,     "cpu_idle",     90,  GANGLIA_VALUE_FLOAT,          "%",          "both",  "%.1f",UDP_HEADER_SIZE+8},
%  {metric_cpu_aidle,    "cpu_aidle",  3800,  GANGLIA_VALUE_FLOAT,          "%",          "both",  "%.1f",UDP_HEADER_SIZE+8},
%  {metric_load_one,     "load_one",     70,  GANGLIA_VALUE_FLOAT,          "",           "both",  "%.2f",UDP_HEADER_SIZE+8},
%  {metric_load_five,    "load_five",   325,  GANGLIA_VALUE_FLOAT,          "",           "both",  "%.2f",UDP_HEADER_SIZE+8},
%  {metric_load_fifteen, "load_fifteen",950,  GANGLIA_VALUE_FLOAT,          "",           "both",  "%.2f",UDP_HEADER_SIZE+8},
%  {metric_proc_run,     "proc_run",    950,  GANGLIA_VALUE_UNSIGNED_INT,   "",           "both",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_proc_total,   "proc_total",  950,  GANGLIA_VALUE_UNSIGNED_INT,   "",           "both",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_mem_free,     "mem_free",    180,  GANGLIA_VALUE_UNSIGNED_INT,   "KB",         "both",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_mem_shared,   "mem_shared",  180,  GANGLIA_VALUE_UNSIGNED_INT,   "KB",         "both",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_mem_buffers,  "mem_buffers", 180,  GANGLIA_VALUE_UNSIGNED_INT,   "KB",         "both",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_mem_cached,   "mem_cached",  180,  GANGLIA_VALUE_UNSIGNED_INT,   "KB",         "both",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_swap_free,    "swap_free",   180,  GANGLIA_VALUE_UNSIGNED_INT,   "KB",         "both",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_gexec,        "gexec",       300,  GANGLIA_VALUE_STRING,         "",           "zero",  "%s",  UDP_HEADER_SIZE+32},
%  {metric_heartbeat,    "heartbeat",    20,  GANGLIA_VALUE_UNSIGNED_INT,   "",           "",      "%u",  UDP_HEADER_SIZE+8},
%  {metric_mtu,          "mtu",        1200,  GANGLIA_VALUE_UNSIGNED_INT,   "",           "both",  "%u",  UDP_HEADER_SIZE+8},
%  {metric_location,     "location",   1200,  GANGLIA_VALUE_STRING,         "(x,y,z)",    "",      "%s",  UDP_HEADER_SIZE+12},
%  {metric_bytes_out,    "bytes_out",   300,  GANGLIA_VALUE_FLOAT,          "bytes/sec",  "both",  "%.2f",UDP_HEADER_SIZE+8},
%  {metric_bytes_in,     "bytes_in",    300,  GANGLIA_VALUE_FLOAT,          "bytes/sec",  "both",  "%.2f",UDP_HEADER_SIZE+8},
%  {metric_pkts_in,      "pkts_in",     300,  GANGLIA_VALUE_FLOAT,          "packets/sec","both",  "%.2f",UDP_HEADER_SIZE+8},
%  {metric_pkts_out,     "pkts_out",    300,  GANGLIA_VALUE_FLOAT,          "packets/sec","both",  "%.2f",UDP_HEADER_SIZE+8},
%  {metric_disk_total,   "disk_total", 1200,  GANGLIA_VALUE_DOUBLE,         "GB",         "both",  "%.3f",UDP_HEADER_SIZE+16},
%  {metric_disk_free,    "disk_free",   180,  GANGLIA_VALUE_DOUBLE,         "GB",         "both",  "%.3f",UDP_HEADER_SIZE+16},
%  {metric_part_max_used,"part_max_used",180, GANGLIA_VALUE_FLOAT,          "%",          "both",  "%.1f",UDP_HEADER_SIZE+8}
% };
%
% Ganglia_25metric *
% Ganglia_25metric_bykey( int key )
% {
%   if(key < 0 || key >= GANGLIA_NUM_25_METRICS)
%     {
%       return NULL;
%     }
%   return &ganglia_25_metric_array[key];
% }
% Ganglia_25metric *
% Ganglia_25metric_byname( char *name )
% {
%   int i;
%   if(!name)
%     {
%       return NULL;
%     }
%   for(i = 0; i< GANGLIA_NUM_25_METRICS; i++)
%     {
%       if(! strcasecmp(name, ganglia_25_metric_array[i].name))
%         {
%           return &ganglia_25_metric_array[i];
%         }
%     }
%   return NULL;
% }
#endif
