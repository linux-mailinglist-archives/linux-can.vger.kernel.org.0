Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0133ACCCE
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhFRNzS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 09:55:18 -0400
Received: from mout.web.de ([212.227.15.4]:40769 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234059AbhFRNzR (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 18 Jun 2021 09:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624024383;
        bh=y1oPXTSlacULC7gAXNsfcuTHfSrl3hCBaOdqsR9Njgk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LhcRKoRQsMfAnub+YFAxFHWDnRvkHB99i50SJbWSi7ZrBRpuKyZVJ9uSWnFCWBjn1
         cUEcMa41d/hI3GuVqqJSsOG2TPGcgW1eDxXhl19HPhWcnaBXXqgPVTPk73UrTmkhOo
         VS9IqsjqP57jrSD/pIp3X0u6M/CpQzAsBKTr2xew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from NBVM2-TW.fritz.box ([84.184.243.4]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LshXV-1lADsE2UlV-012EbP; Fri, 18
 Jun 2021 15:53:03 +0200
From:   Thomas Wagner <thwa1@web.de>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Thomas Wagner <thwa1@web.de>
Subject: [PATCH] libsocketcan: Add new functions to get/set CAN FD bittimings
Date:   Fri, 18 Jun 2021 15:51:27 +0200
Message-Id: <20210618135127.250251-1-thwa1@web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Hrkn/G5lM9VPbCqBH1ZP9/Y1ZsGBbm9aGr1pgjRndtmBBBShlp
 xMmLIPx2KRzEe9vL/ZoWgMp/JixiDHVTzoSVKVtCVt0WE1qy91nEHDcGNAwbXjOtMaTOzdN
 U0n9Ztx8ZKt1G/rluhgn+O3GQv0VnQYYMAiVGwwHG+RAw6DpOe5lVqGpttPU5RZoc9FIkyb
 GEqoVJdRt8Uz4OUxO5jNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SFRqblLFwAA=:gAyPA2fdJnt6LRdgc86L8r
 GU5WA7Bvzl/7TsTAkj/idGnNgiZVoXR7zqpL6gHfkVbyLayGUZo1lmBDDUXosBTTr54lF6y1b
 Xq+CghHtvAikNlxDBHb3XYgwD4CvL5ILkGJhD/1m9JJja//zk+dvDychzPJ1fAz6sIz4Q6zfj
 p9MeZeJUztrk/PVKa6Iz9AWL7Bmzka2WZuEU6jj+30ogqzQ0peaHw1aLGcyv/mZSpO4WIfzHr
 pvngI+61oquzzh8fCOQrlavmiOQ5vUfsBkFPJ6nLI2tfSzg/zey3BG24C/lhCZqeh9PjIxhXA
 xjyRihD0yfvJLliS3mMqFLHcfNdqVbxbEs63z0R1iym5cckiaQ1iWXnSPrQKJyrtuEpTg+Nx3
 PCxQPLNJ+dJlk4OHieA22aZPavF7fTUbJAXE82h/6DMEz8gB3WhjKwgWq0TfhF6TJozpqLxaI
 YbilCgZsCgWXIMHVy/Gw+Q9ml5Oy+9g9vSn2X/eEMn0jEvStG2rOwwr6SkGjlT1mtSvasj++e
 4dDEPMvjZvjwlT0/jFcME9cJbvpcxu6i1gXe8myb0qsK2FvZyOXj9lBBEzQwJuU8L+7m3cAmo
 AYM741GQFk1ugLHXCIFPtKzq7nl8zAB0E3VVU7ciHvdmeTZ3rPjlOA/VxRTgwSq6/ZaoJcF8z
 97rD5pn/PWs6Z2VGNTsZ+Z9qXvhVImoRquu1TLYxFjtTbgBipx/RYsnHeh4gC5VxipQqYeUkO
 /8/iCbfzgpi7etkBq3fAN/+2giF+vSQxgynXo6zw83vd/+54EML/PSLQfEMr9CcthLIeLqezc
 nTevXFym5tNhtwcm2aF8Wlpu2Fd5rFYDlssUqAOnx0v8nDCRLXRXMp/luyKuz0vHUV72AGcdX
 yDCh5Q0ku6dUgMDTfsHjXFhn/FkOwDXB0Wd8JahpX19di/1d3VKHRpZaEQcA2MpcxIeiv7NEl
 GlcV6EJ7Ijpgzz7Xn7v6XPBhj2rqX/DSGcY6SpRyWYMztgNULX8gufZr/8u4ltDjdr8BpE47F
 qRVK6Jucr51e7y0VXJ62Tq1ImBO+7OX/hFD2efWqqEvFbhG93Jq0ABYn9tBa+5+quq9O7I8KJ
 Gchy0AMq861AE6Kehn7MMRR7ZDjTIKCI49N
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds new functions to get/set bittimings for both can fd phases=
,
arbitration phase and data phase.

It mimics the same behaviour as the ip link tool where can fd bitrates alw=
ays
have to be set by calling i.e.:

ip link set can0 type can bitrate 500000 dbitrate 2000000 fd on


Signed-off-by: Thomas Wagner <thwa1@web.de>
Tested-by: Thomas Wagner <thwa1@web.de>
=2D--
 include/libsocketcan.h |   5 +
 src/libsocketcan.c     | 235 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 235 insertions(+), 5 deletions(-)

diff --git a/include/libsocketcan.h b/include/libsocketcan.h
index 1603a7b..844104d 100644
=2D-- a/include/libsocketcan.h
+++ b/include/libsocketcan.h
@@ -40,16 +40,21 @@ int can_do_start(const char *name);

 int can_set_restart_ms(const char *name, __u32 restart_ms);
 int can_set_bittiming(const char *name, struct can_bittiming *bt);
+int can_set_fd_bittimings(const char *name, struct can_bittiming *bt, str=
uct can_bittiming *dbt);
 int can_set_ctrlmode(const char *name, struct can_ctrlmode *cm);
 int can_set_bitrate(const char *name, __u32 bitrate);
+int can_set_fd_bitrates(const char *name, __u32 bitrate, __u32 dbitrate);
 int can_set_bitrate_samplepoint(const char *name, __u32 bitrate, __u32 sa=
mple_point);
+int can_set_fd_bitrates_samplepoints(const char *name, __u32 bitrate, __u=
32 sample_point, __u32 dbitrate, __u32 dsample_point);

 int can_get_restart_ms(const char *name, __u32 *restart_ms);
 int can_get_bittiming(const char *name, struct can_bittiming *bt);
+int can_get_data_bittiming(const char *name, struct can_bittiming *bt);
 int can_get_ctrlmode(const char *name, struct can_ctrlmode *cm);
 int can_get_state(const char *name, int *state);
 int can_get_clock(const char *name, struct can_clock *clock);
 int can_get_bittiming_const(const char *name, struct can_bittiming_const =
*btc);
+int can_get_data_bittiming_const(const char *name, struct can_bittiming_c=
onst *btc);
 int can_get_berr_counter(const char *name, struct can_berr_counter *bc);
 int can_get_device_stats(const char *name, struct can_device_stats *cds);
 int can_get_link_stats(const char *name, struct rtnl_link_stats64 *rls);
diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index 60142cc..e7a334f 100644
=2D-- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -66,6 +66,8 @@
 #define GET_BERR_COUNTER 7
 #define GET_XSTATS 8
 #define GET_LINK_STATS 9
+#define GET_DATA_BITTIMING 10
+#define GET_DATA_BITTIMING_CONST 11

 struct get_req {
 	struct nlmsghdr n;
@@ -84,6 +86,7 @@ struct req_info {
 	__u32 restart_ms;
 	struct can_ctrlmode *ctrlmode;
 	struct can_bittiming *bittiming;
+	struct can_bittiming *dbittiming;
 };

 /**
@@ -486,6 +489,16 @@ static int do_get_nl_link(int fd, __u8 acquire, const=
 char *name, void *res)
 				} else
 					fprintf(stderr, "no bittiming data found\n");

+				break;
+			case GET_DATA_BITTIMING:
+				if (can_attr[IFLA_CAN_DATA_BITTIMING]) {
+					memcpy(res,
+					       RTA_DATA(can_attr[IFLA_CAN_DATA_BITTIMING]),
+					       sizeof(struct can_bittiming));
+					ret =3D 0;
+				} else
+					fprintf(stderr, "no data bittiming data found\n");
+
 				break;
 			case GET_CTRLMODE:
 				if (can_attr[IFLA_CAN_CTRLMODE]) {
@@ -517,6 +530,16 @@ static int do_get_nl_link(int fd, __u8 acquire, const=
 char *name, void *res)
 				} else
 					fprintf(stderr, "no bittiming_const data found\n");

+				break;
+			case GET_DATA_BITTIMING_CONST:
+				if (can_attr[IFLA_CAN_DATA_BITTIMING_CONST]) {
+					memcpy(res,
+					       RTA_DATA(can_attr[IFLA_CAN_DATA_BITTIMING_CONST]),
+					       sizeof(struct can_bittiming_const));
+					ret =3D 0;
+				} else
+					fprintf(stderr, "no data bittiming_const data found\n");
+
 				break;
 			case GET_BERR_COUNTER:
 				if (can_attr[IFLA_CAN_BERR_COUNTER]) {
@@ -648,6 +671,12 @@ static int do_set_nl_link(int fd, __u8 if_state, cons=
t char *name,
 				  sizeof(struct can_bittiming));
 		}

+		if (req_info->dbittiming !=3D NULL) {
+			addattr_l(&req.n, 1024, IFLA_CAN_DATA_BITTIMING,
+				  req_info->dbittiming,
+				  sizeof(struct can_bittiming));
+		}
+
 		if (req_info->ctrlmode !=3D NULL) {
 			addattr_l(&req.n, 1024, IFLA_CAN_CTRLMODE,
 				  req_info->ctrlmode,
@@ -878,7 +907,7 @@ int can_set_ctrlmode(const char *name, struct can_ctrl=
mode *cm)
  * line. e.g. "can0"
  * @param bt pointer to a can_bittiming struct
  *
- * This sets the bittiming of the can device. This is for advantage usage=
. In
+ * This sets the bittiming of the can device. This is for advanced usage.=
 In
  * normal cases you should use can_set_bitrate to simply define the bitra=
te and
  * let the driver automatically calculate the bittiming. You will only ne=
ed this
  * function if you wish to define the bittiming in expert mode with fully
@@ -916,6 +945,64 @@ int can_set_bittiming(const char *name, struct can_bi=
ttiming *bt)
 	return set_link(name, 0, &req_info);
 }

+/**
+ * @ingroup extern
+ * can_set_fd_bittimings - setup the bittimings for can fd.
+ *
+ * @param name name of the can fd device. This is the netdev name, as ifc=
onfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the =
can
+ * line. e.g. "can0"
+ * @param bt pointer to a can_bittiming struct used for arbitration phase
+ * @param dbt pointer to a can_bittiming struct used for data phase
+ *
+ * By calling this function can fd mode is automatically set.
+ *
+ * This sets the bittiming of the can fd device. This is for advanced usa=
ge. In
+ * normal cases you should use can_set_fd_bitrates to simply define the b=
itrate and
+ * let the driver automatically calculate the bittiming. You will only ne=
ed this
+ * function if you wish to define the bittimings in expert mode with full=
y
+ * manually defined timing values.
+ * You have to define the bittiming structs yourself. a can_bittiming str=
uct
+ * consists of:
+ *
+ * @code
+ * struct can_bittiming {
+ *	__u32 bitrate;
+ *	__u32 sample_point;
+ *	__u32 tq;
+ *	__u32 prop_seg;
+ *	__u32 phase_seg1;
+ *	__u32 phase_seg2;
+ *	__u32 sjw;
+ *	__u32 brp;
+ * }
+ * @endcode
+ *
+ * to define a customized bittiming, you have to define tq, prop_seq,
+ * phase_seg1, phase_seg2 and sjw. See http://www.can-cia.org/index.php?i=
d=3D88
+ * for more information about bittiming and synchronizations on can bus.
+ *
+ * @return 0 if success
+ * @return -1 if failed
+ */
+
+int can_set_fd_bittimings(const char *name, struct can_bittiming *bt, str=
uct can_bittiming *dbt)
+{
+	struct can_ctrlmode cm;
+    memset(&cm, 0, sizeof(cm));
+    cm.mask =3D CAN_CTRLMODE_FD;
+    cm.flags =3D CAN_CTRLMODE_FD;
+
+    /* netlink expects both, timings and the fd flag, to always be set si=
multaneously */
+	struct req_info req_info =3D {
+		.bittiming =3D bt,
+		.dbittiming =3D dbt,
+		.ctrlmode =3D &cm
+	};
+
+	return set_link(name, 0, &req_info);
+}
+
 /**
  * @ingroup extern
  * can_set_bitrate - setup the bitrate.
@@ -924,7 +1011,7 @@ int can_set_bittiming(const char *name, struct can_bi=
ttiming *bt)
  * in your system. usually it contains prefix "can" and the numer of the =
can
  * line. e.g. "can0"
  * @param bitrate bitrate of the can bus
- *
+
  * This is the recommended way to setup the bus bit timing. You only have=
 to
  * give a bitrate value here. The exact bit timing will be calculated
  * automatically. To use this function, make sure that CONFIG_CAN_CALC_BI=
TTIMING
@@ -945,6 +1032,43 @@ int can_set_bitrate(const char *name, __u32 bitrate)
 	return can_set_bittiming(name, &bt);
 }

+/**
+ * @ingroup extern
+ * can_set_fd_bitrates - setup the bitrates for can fd.
+ *
+ * @param name name of the can fd device. This is the netdev name, as ifc=
onfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the =
can
+ * line. e.g. "can0"
+ * @param bitrate bitrate of the can fd bus during arbitration phase
+ * @param dbitrate bitrate of the can fd bus during data phase
+ *
+ * By calling this function can fd mode is automatically set.
+ *
+ * This is the recommended way to setup the bus bit timings. You only hav=
e to
+ * give both bitrate values here. The exact bit timings will be calculate=
d
+ * automatically. To use this function, make sure that CONFIG_CAN_CALC_BI=
TTIMING
+ * is set to y in your kernel configuration. Bitrate can be a value betwe=
en
+ * 1000(1kbit/s) and 1000000(1000kbit/s) for arbitration phase. For data =
phase
+ * bitrate can be a value between 1000(1kbit/s) and 14049876(1kbit/s).
+ *
+ * @return 0 if success
+ * @return -1 if failed
+ */
+
+int can_set_fd_bitrates(const char *name, __u32 bitrate, __u32 dbitrate)
+{
+	struct can_bittiming bt;
+	struct can_bittiming dbt;
+
+	memset(&bt, 0, sizeof(bt));
+	bt.bitrate =3D bitrate;
+
+	memset(&dbt, 0, sizeof(dbt));
+	dbt.bitrate =3D dbitrate;
+
+	return can_set_fd_bittimings(name, &bt, &dbt);
+}
+
 /**
  * @ingroup extern
  * can_set_bitrate_samplepoint - setup the bitrate.
@@ -974,6 +1098,44 @@ int can_set_bitrate_samplepoint(const char *name, __=
u32 bitrate,
 	return can_set_bittiming(name, &bt);
 }

+/**
+ * @ingroup extern
+ * can_set_fd_bitrates_samplepoints - setup the bitrates.
+ *
+ * @param name name of the can fd device. This is the netdev name, as ifc=
onfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the =
can
+ * line. e.g. "can0"
+ * @param bitrate bitrate of the can fd bus during arbitration phase
+ * @param sample_point sample point value of the can fd bus during arbitr=
ation phase
+ * @param dbitrate bitrate of the can fd bus during data phase
+ * @param dsample_point sample point value of the can fd bus during data =
phase
+ *
+ * By calling this function can fd mode is automatically set.
+ *
+ * This one is similar to can_set_fd_bitrates, only you can additionally =
set up the
+ * time points for sampling (sample point) customly instead of using the
+ * CIA recommended value. sample_point can be a value between 0 and 999.
+ *
+ * @return 0 if success
+ * @return -1 if failed
+ */
+int can_set_fd_bitrates_samplepoints(const char *name, __u32 bitrate,
+				__u32 sample_point, __u32 dbitrate, __u32 dsample_point)
+{
+	struct can_bittiming bt;
+	struct can_bittiming dbt;
+
+	memset(&bt, 0, sizeof(bt));
+	bt.bitrate =3D bitrate;
+	bt.sample_point =3D sample_point;
+
+	memset(&dbt, 0, sizeof(dbt));
+	dbt.bitrate =3D dbitrate;
+	dbt.sample_point =3D dsample_point;
+
+	return can_set_fd_bittimings(name, &bt, &dbt);
+}
+
 /**
  * @ingroup extern
  * can_get_state - get the current state of the device
@@ -1040,7 +1202,9 @@ int can_get_restart_ms(const char *name, __u32 *rest=
art_ms)
  * line. e.g. "can0"
  * @param bt pointer to the bittiming struct.
  *
- * This one stores the current bittiming configuration.
+ * This one stores the current bittiming configuration. For can fd it hol=
ds
+ * the bittiming for the arbitration phase. To get the bittiming for the =
data phase
+ * use can_get_data_bittimings.
  *
  * Please see can_set_bittiming for more information about bit timing.
  *
@@ -1052,6 +1216,28 @@ int can_get_bittiming(const char *name, struct can_=
bittiming *bt)
 	return get_link(name, GET_BITTIMING, bt);
 }

+/**
+ * @ingroup extern
+ * can_get_data_bittimings - get the current data phase bittimnig configu=
ration.
+ *
+ * @param name name of the can fd device. This is the netdev name, as ifc=
onfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the =
can
+ * line. e.g. "can0"
+ * @param bt pointer to the bittiming struct.
+ *
+ * This one stores the current data phase bittiming configuration. To get=
 the bittiming
+ * for the arbitration phase use can_get_bittiming.
+ *
+ * Please see can_set_fd_bittimings for more information about bit timing=
.
+ *
+ * @return 0 if success
+ * @return -1 if failed
+ */
+int can_get_data_bittiming(const char *name, struct can_bittiming *bt)
+{
+	return get_link(name, GET_DATA_BITTIMING, bt);
+}
+
 /**
  * @ingroup extern
  * can_get_ctrlmode - get the current control mode.
@@ -1104,8 +1290,10 @@ int can_get_clock(const char *name, struct can_cloc=
k *clock)
  * line. e.g. "can0"
  * @param btc pointer to the bittiming constant struct.
  *
- * This one stores the hardware dependent bittiming constant. The
- * can_bittiming_const struct consists:
+ * This one stores the hardware dependent bittiming constant. For can fd =
it holds
+ * the bittiming constant for the arbitration phase. To get the bittiming=
 constant
+ * for the data phase use can_get_data_bittiming_const.The can_bittiming_=
const
+ * struct consists:
  *
  * @code
  * struct can_bittiming_const {
@@ -1132,6 +1320,43 @@ int can_get_bittiming_const(const char *name, struc=
t can_bittiming_const *btc)
 	return get_link(name, GET_BITTIMING_CONST, btc);
 }

+/**
+ * @ingroup extern
+ * can_get_data_bittiming_const - get the current data phase bittimnig co=
nfiguration.
+ *
+ * @param name name of the can fd device. This is the netdev name, as ifc=
onfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the =
can
+ * line. e.g. "can0"
+ * @param btc pointer to the bittiming constant struct.
+ *
+ * This one stores the hardware dependent bittiming constant for the data=
 phase. To get
+ * the bittiming constant for the arbitration phase use can_get_bittiming=
.
+ * The can_bittiming_const struct consists:
+ *
+ * @code
+ * struct can_bittiming_const {
+ *	char name[16];
+ *	__u32 tseg1_min;
+ *	__u32 tseg1_max;
+ *	__u32 tseg2_min;
+ *	__u32 tseg2_max;
+ *	__u32 sjw_max;
+ *	__u32 brp_min;
+ *	__u32 brp_max;
+ *	__u32 brp_inc;
+ *	};
+ * @endcode
+ *
+ * The information in this struct is used to calculate the bus bit timing
+ * automatically.
+ *
+ * @return 0 if success
+ * @return -1 if failed
+ */
+int can_get_data_bittiming_const(const char *name, struct can_bittiming_c=
onst *btc)
+{
+	return get_link(name, GET_DATA_BITTIMING_CONST, btc);
+}

 /**
  * @ingroup extern
=2D-
2.25.1

