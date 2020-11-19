Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFED2B8DE9
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKSItd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 03:49:33 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:35408 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKSItc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 03:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605775769;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=/Q/dZRxkWml2r+778HpRIhp2yJNfL/o3TfQPimFfMrM=;
        b=XSsnLFyNg9usCl7e0ruYJ+K5pDysfwZiaaHnUKaKyXldC5rkHwrAWoNgTmIer6ApM5
        zZUDk98qa++LcT+ZuSMgdHb36vPJLqhub+rVyknbQhLaEoi3vT27kZQO4Ut6rupe+xm9
        qbSnN+7taIEsYqzVLp+BfF3T471DkGnYb3qubM90vJTKN0dgz3/h11pcaTwItES9BkmY
        XxWgE7b/HGbYSleZGCUY9Z4+5jUghqmNqSAwUS5EJdgsiR+YajVWMK368gJpk7jlM/sD
        /5ZMwucg2vATWWcWmAnTPI04YTX6TT5hCcaUtzoW2d35aipDTbyW9sBi8W3177K1W8mu
        scWQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJy4jsiTZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwAJ8nRSLU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Nov 2020 09:49:27 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org, mkl@pengutronix.de,
        mailhol.vincent@wanadoo.fr
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH net-next v2] can: gw: support modification of Classical CAN DLCs
Date:   Thu, 19 Nov 2020 09:49:21 +0100
Message-Id: <20201119084921.2621-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add support for data length code modifications for Classical CAN.

The netlink configuration interface always allowed to pass any value
that fits into a byte, therefore only the modification process had to be
extended to handle the raw DLC represenation of Classical CAN frames.

When a DLC value from 0 .. F is provided for Classical CAN frame
modifications the 'len' value is modified as-is with the exception that
potentially existing 9 .. F DLC values in the len8_dlc element are moved
to the 'len' element for the modification operation by mod_retrieve_ccdlc().

After the modification the Classical CAN frame DLC information is brought
back into the correct format by mod_store_ccdlc() which is filling 'len'
and 'len8_dlc' accordingly.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---
v2: remove unnecessary mod_retrieve_ccdlc() for 'set' modification
---
 include/uapi/linux/can/gw.h |  4 +-
 net/can/gw.c                | 78 +++++++++++++++++++++++++++++++++----
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index c2190bbe21d8..e4f0957554f3 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -96,12 +96,12 @@ enum {
 
 #define CGW_MOD_FUNCS 4 /* AND OR XOR SET */
 
 /* CAN frame elements that are affected by curr. 3 CAN frame modifications */
 #define CGW_MOD_ID	0x01
-#define CGW_MOD_DLC	0x02		/* contains the data length in bytes */
-#define CGW_MOD_LEN	CGW_MOD_DLC	/* CAN FD length representation */
+#define CGW_MOD_DLC	0x02		/* Classical CAN data length code */
+#define CGW_MOD_LEN	CGW_MOD_DLC	/* CAN FD (plain) data length */
 #define CGW_MOD_DATA	0x04
 #define CGW_MOD_FLAGS	0x08		/* CAN FD flags */
 
 #define CGW_FRAME_MODS 4 /* ID DLC/LEN DATA FLAGS */
 
diff --git a/net/can/gw.c b/net/can/gw.c
index de5e8859ec9b..8598d9da0e5f 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -197,10 +197,72 @@ static void mod_xor_fddata(struct canfd_frame *cf, struct cf_mod *mod)
 static void mod_set_fddata(struct canfd_frame *cf, struct cf_mod *mod)
 {
 	memcpy(cf->data, mod->modframe.set.data, CANFD_MAX_DLEN);
 }
 
+/* retrieve valid CC DLC value and store it into 'len' */
+static void mod_retrieve_ccdlc(struct canfd_frame *cf)
+{
+	struct can_frame *ccf = (struct can_frame *)cf;
+
+	/* len8_dlc is only valid if len == CAN_MAX_DLEN */
+	if (ccf->len != CAN_MAX_DLEN)
+		return;
+
+	/* do we have a valid len8_dlc value from 9 .. 15 ? */
+	if (ccf->len8_dlc > CAN_MAX_DLEN && ccf->len8_dlc <= CAN_MAX_RAW_DLC)
+		ccf->len = ccf->len8_dlc;
+}
+
+/* convert valid CC DLC value in 'len' into struct can_frame elements */
+static void mod_store_ccdlc(struct canfd_frame *cf)
+{
+	struct can_frame *ccf = (struct can_frame *)cf;
+
+	/* clear potential leftovers */
+	ccf->len8_dlc = 0;
+
+	/* plain data length 0 .. 8 - that was easy */
+	if (ccf->len <= CAN_MAX_DLEN)
+		return;
+
+	/* potentially broken values are catched in can_can_gw_rcv() */
+	if (ccf->len > CAN_MAX_RAW_DLC)
+		return;
+
+	/* we have a valid dlc value from 9 .. 15 in ccf->len */
+	ccf->len8_dlc = ccf->len;
+	ccf->len = CAN_MAX_DLEN;
+}
+
+static void mod_and_ccdlc(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	mod_retrieve_ccdlc(cf);
+	mod_and_len(cf, mod);
+	mod_store_ccdlc(cf);
+}
+
+static void mod_or_ccdlc(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	mod_retrieve_ccdlc(cf);
+	mod_or_len(cf, mod);
+	mod_store_ccdlc(cf);
+}
+
+static void mod_xor_ccdlc(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	mod_retrieve_ccdlc(cf);
+	mod_xor_len(cf, mod);
+	mod_store_ccdlc(cf);
+}
+
+static void mod_set_ccdlc(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	mod_set_len(cf, mod);
+	mod_store_ccdlc(cf);
+}
+
 static void canframecpy(struct canfd_frame *dst, struct can_frame *src)
 {
 	/* Copy the struct members separately to ensure that no uninitialized
 	 * data are copied in the 3 bytes hole of the struct. This is needed
 	 * to make easy compares of the data in the struct cf_mod.
@@ -840,12 +902,12 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			mod->modtype.and = mb.modtype;
 
 			if (mb.modtype & CGW_MOD_ID)
 				mod->modfunc[modidx++] = mod_and_id;
 
-			if (mb.modtype & CGW_MOD_LEN)
-				mod->modfunc[modidx++] = mod_and_len;
+			if (mb.modtype & CGW_MOD_DLC)
+				mod->modfunc[modidx++] = mod_and_ccdlc;
 
 			if (mb.modtype & CGW_MOD_DATA)
 				mod->modfunc[modidx++] = mod_and_data;
 		}
 
@@ -856,12 +918,12 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			mod->modtype.or = mb.modtype;
 
 			if (mb.modtype & CGW_MOD_ID)
 				mod->modfunc[modidx++] = mod_or_id;
 
-			if (mb.modtype & CGW_MOD_LEN)
-				mod->modfunc[modidx++] = mod_or_len;
+			if (mb.modtype & CGW_MOD_DLC)
+				mod->modfunc[modidx++] = mod_or_ccdlc;
 
 			if (mb.modtype & CGW_MOD_DATA)
 				mod->modfunc[modidx++] = mod_or_data;
 		}
 
@@ -872,12 +934,12 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			mod->modtype.xor = mb.modtype;
 
 			if (mb.modtype & CGW_MOD_ID)
 				mod->modfunc[modidx++] = mod_xor_id;
 
-			if (mb.modtype & CGW_MOD_LEN)
-				mod->modfunc[modidx++] = mod_xor_len;
+			if (mb.modtype & CGW_MOD_DLC)
+				mod->modfunc[modidx++] = mod_xor_ccdlc;
 
 			if (mb.modtype & CGW_MOD_DATA)
 				mod->modfunc[modidx++] = mod_xor_data;
 		}
 
@@ -888,12 +950,12 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			mod->modtype.set = mb.modtype;
 
 			if (mb.modtype & CGW_MOD_ID)
 				mod->modfunc[modidx++] = mod_set_id;
 
-			if (mb.modtype & CGW_MOD_LEN)
-				mod->modfunc[modidx++] = mod_set_len;
+			if (mb.modtype & CGW_MOD_DLC)
+				mod->modfunc[modidx++] = mod_set_ccdlc;
 
 			if (mb.modtype & CGW_MOD_DATA)
 				mod->modfunc[modidx++] = mod_set_data;
 		}
 	}
-- 
2.29.2

