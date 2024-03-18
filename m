Return-Path: <linux-can+bounces-404-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7E87E7AF
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 11:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141F01C21209
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B142E827;
	Mon, 18 Mar 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PZv/P1Ip";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="B+LIB+qd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BAF2DF92
	for <linux-can@vger.kernel.org>; Mon, 18 Mar 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759014; cv=pass; b=DaY0COJvQ8imSyhzvU9XKaI83q0ahsr3bnGB1wF7WRgtlBivFj0mJf4QWX09iWNx610N5j5ONp0Sfcwibtu3RVFoKs1JBC1FT93BlbSPeakc4EEem15Ez/ZgbLzyDLoDgS+Rb/Cd4Vaactyh7sRllX/i8FzV/+dayXtxb9zV1AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759014; c=relaxed/simple;
	bh=LgsuPaPyIVOXHIFhozoqSnXxAjNx/SNh8xkose2bVwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLpxwCXaLYU0gZVXg6UCUiwuODLzugQYSg+C6RYYkFjKcuZQ2MCZX/M4EiU2oVqUs/qbs7HfDMpHGFi+LUurjbRqY+5PjqjE9m6ooFMYxaXv3j2ya1bXOibTSghnLn0fVoDiHkGFLE80q1jayoRGatl7nt0Z/hudxx+feWcgLK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PZv/P1Ip; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=B+LIB+qd; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1710758829; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BqzZoktyeGMbb3r+qnej5qlxUq5LZAvDNhXSZLw/vXE5wHIzPdddmeHe/cDuWTO6yE
    sj49EBYNUhYDcR96dFOBuaVYC/b/KiuJNeB28VtligGqYU23HLPGcTwVSCw9ELorf5Sn
    LpflT11lZOV8U//QqjHWnlSFx4YWVDMdU4S+fIXvtwSRmBosQrsioPbqh/33IUrVB6+2
    tblhpsNwPYJNSjHRYs/+oNqYqe/yZl7/+6JtXFya6LFKFSLSoJr0oI/N4RN0UsO3x9Xf
    olk/u9bSUWZKlrS6mLXhsntm0f/83VigvTpKyyWk3KhbKEvbv2E42HYZ+scauBLYb9ql
    pYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F8sbNd0uDANywkJdWL+Ji/aT4wer88RbNkUseVCmBK4=;
    b=XLqj5Llr0pGx1g7IdrQfN6F/p83TAECLFHbBVJWGiijtDgthxcGw1Ttybs1stjo0L1
    iKvGG9LLFMhkPv8YOtCaYT9YlXeVSXv+ifDLF5dB0GCbDXPKgmxY7P0PSKVpLA2uRxd6
    OKSZ8oSV0cjNFqKIMiWPV3sw15u4gFWEpbOEb/B4o1yosVvJUCXhYJvy6YSoDfVKAD9m
    cqRkYQVAqrqKTHtRQCr1L2e0R9a6fDpaj0d+UJ7nLzQWA1/vH427m9Y9hlqjQ/15MShU
    RGTTcREpkfnGlaGctGHonbh15Kzx56UDfVbRSNWAORS2OGwbd/ig18SJk2hfS1lj0cPH
    L8Xg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F8sbNd0uDANywkJdWL+Ji/aT4wer88RbNkUseVCmBK4=;
    b=PZv/P1IpUj3hJkvLcRZ2fvQzdz1oGA4AZVgGxcCtIGdh+p5bTzFXKvOYBEBV4pjWDg
    hgWPDQ4UcGRU3EOvcbgacU7SP/KECQ2fTdRxXGUx2wZiPYthnstmJb3GdtVsstTjMqqT
    22aJ7PMaVNMp45H+BGSbllkVSuYrh9bbf2Yp/jKAsixFyN3Q7a2QliFG+i/95jyOveOE
    grCiMQG6DgankKK6FkVi2EQI0VP/iyKWWpzIZ+BYGnFJbFh7ERr2eEZDXYaZMTDpYVjU
    0Wx4VE8w4klqXxzM5tSC9vJQ0iZVjDJX1tG2+a/GHlnM5jrrR++tg3rHR8IVih9Jt/vq
    EsbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F8sbNd0uDANywkJdWL+Ji/aT4wer88RbNkUseVCmBK4=;
    b=B+LIB+qdRLKDeZxeNs9iapORR1/76Z3tKv8DPagl1Lp7vIK1+0WS8KG3Ir1qZY6tGX
    lcFZCNbguLZKujWagCCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 50.2.2 AUTH)
    with ESMTPSA id K0cc6102IAl98Tq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Mar 2024 11:47:09 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Guy Harris <gharris@sonic.net>
Cc: wireshark-dev@wireshark.org,
	linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/4] socketcan: display CANFD_FDF and CANXL_XLF flag content
Date: Mon, 18 Mar 2024 11:46:41 +0100
Message-ID: <20240318104643.24098-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318104643.24098-1-socketcan@hartkopp.net>
References: <20240318104643.24098-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Display the officially defined bits for CAN XL and CAN FD.
While CANXL_XLF is a mandatory set bit value for CAN XL frames
the CANFD_FDF bit might be set based on the used Linux kernel
version. So both bits present valuable content for the user.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 epan/dissectors/packet-socketcan.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/epan/dissectors/packet-socketcan.c b/epan/dissectors/packet-socketcan.c
index e9fcdb2dd8..2e29484085 100644
--- a/epan/dissectors/packet-socketcan.c
+++ b/epan/dissectors/packet-socketcan.c
@@ -75,18 +75,20 @@ static int hf_can_err_trx_canl;
 static int hf_can_err_ctrl_specific;
 
 static int hf_canxl_priority;
 static int hf_canxl_vcid;
 static int hf_canxl_secflag;
+static int hf_canxl_xlflag;
 static int hf_canxl_sdu_type;
 static int hf_canxl_len;
 static int hf_canxl_acceptance_field;
 
 static expert_field ei_can_err_dlc_mismatch;
 
 static int hf_canfd_brsflag;
 static int hf_canfd_esiflag;
+static int hf_canfd_fdflag;
 
 static gint ett_can;
 static gint ett_can_fd;
 static gint ett_can_xl;
 
@@ -107,13 +109,10 @@ static heur_dtbl_entry_t *heur_dtbl_entry;
 #define CAN_LEN_OFFSET     4
 #define CAN_DATA_OFFSET    8
 
 #define CANFD_FLAG_OFFSET  5
 
-#define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
-#define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
-
 #define CANXL_FLAGS_OFFSET CAN_LEN_OFFSET
 #define CANXL_LEN_OFFSET   6
 #define CANXL_DATA_OFFSET  12
 
 static dissector_table_t can_id_dissector_table = NULL;
@@ -564,10 +563,11 @@ dissect_socketcan_common(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, gu
         NULL,
     };
     static int * const canfd_flag_fields[] = {
         &hf_canfd_brsflag,
         &hf_canfd_esiflag,
+        &hf_canfd_fdflag,
         NULL,
     };
     static int * const can_err_flags[] = {
         &hf_can_errflag,
         &hf_can_err_tx_timeout,
@@ -587,10 +587,11 @@ dissect_socketcan_common(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, gu
         &hf_canxl_vcid,
         NULL,
     };
     static int * const canxl_flag_fields[] = {
         &hf_canxl_secflag,
+        &hf_canxl_xlflag,
         NULL,
     };
 
     /* determine CAN packet type */
     if (can_packet_type == PACKET_TYPE_UNKNOWN) {
@@ -860,10 +861,12 @@ proto_register_socketcan(void) {
             "Padding", "can.padding", FT_BYTES, BASE_NONE, NULL, 0x0, NULL, HFILL } },
         { &hf_canfd_brsflag, {
             "Bit Rate Setting", "canfd.flags.brs", FT_BOOLEAN, 8, NULL, CANFD_BRS, NULL, HFILL } },
         { &hf_canfd_esiflag, {
             "Error State Indicator", "canfd.flags.esi", FT_BOOLEAN, 8, NULL, CANFD_ESI, NULL, HFILL } },
+        { &hf_canfd_fdflag, {
+            "FD Frame", "canfd.flags.fdf", FT_BOOLEAN, 8, NULL, CANFD_FDF, NULL, HFILL } },
         { &hf_can_err_tx_timeout, {
             "Transmit timeout", "can.err.tx_timeout", FT_BOOLEAN, 32, NULL, CAN_ERR_TX_TIMEOUT, NULL, HFILL } },
         { &hf_can_err_lostarb, {
             "Lost arbitration", "can.err.lostarb", FT_BOOLEAN, 32, NULL, CAN_ERR_LOSTARB, NULL, HFILL } },
         { &hf_can_err_ctrl, {
@@ -926,10 +929,12 @@ proto_register_socketcan(void) {
             "Priority", "canxl.priority", FT_UINT32, BASE_DEC, NULL, 0x0000FFFF, NULL, HFILL } },
         { &hf_canxl_vcid, {
             "VCID", "canxl.vcid", FT_UINT32, BASE_DEC, NULL, 0x00FF0000, NULL, HFILL } },
         { &hf_canxl_secflag, {
             "Simple Extended Context", "canxl.flags.sec", FT_BOOLEAN, 8, NULL, CANXL_SEC, NULL, HFILL } },
+        { &hf_canxl_xlflag, {
+            "XL Frame", "canxl.flags.xl", FT_BOOLEAN, 8, NULL, CANXL_XLF, NULL, HFILL } },
         { &hf_canxl_sdu_type, {
             "SDU type", "canxl.sdu_type", FT_UINT8, BASE_HEX, VALS(canxl_sdu_type_vals), 0, NULL, HFILL } },
         { &hf_canxl_len, {
             "Frame-Length", "canxl.len", FT_UINT16, BASE_DEC, NULL, 0x0, NULL, HFILL } },
         { &hf_canxl_acceptance_field, {
-- 
2.43.0


