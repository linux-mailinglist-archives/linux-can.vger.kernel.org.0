Return-Path: <linux-can+bounces-399-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B058687E7A4
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 11:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAB01F22415
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5F2E651;
	Mon, 18 Mar 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="i8FcN3CG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DYD9nC/q"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70324B26
	for <linux-can@vger.kernel.org>; Mon, 18 Mar 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758840; cv=pass; b=arI+BGWc0/jUle7SZx0tX8F5h1YbVrK54WRHeo15Z1qkxEsQ0N2wvcy9x2sJghpFyMKoafcvM9evb180sZsQUSqtRQKYsrjcrbuooB4ZyKkLMHKdB3aGqgygPTQ6AKlE07S3te//uWYGBtdm+AButsSC7DbeTPy/qQSouFFxXvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758840; c=relaxed/simple;
	bh=nebzjnPhS4Yh9xlKcbXdA0kBrfssjHyeHkUK1WV/VCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThyL54EqFPCeMaKyTkgR6ujNazaEaKUOURaEoYsNKw1HJlvgnX0yAriyYXpTw+7nPZMXyGKRiTl0/XryKz8nkQr7pYPFwn39ovACgUJVJSa7yoFfOT53EBFD2r2VPk/AG6xGT2MI6P3bI8SY7u7e+4bbrNFLhZdi2ygduZHoKAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=i8FcN3CG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DYD9nC/q; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1710758829; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DesRn3ZoZ43L2c5OFqmAS73O6WJ5Lv5KovApRY4Ep1rIMnHIIxwcYqMnVmaweT+18q
    M7rxlDlQXDaRnjMH17x1xvM6IYKtZgJ6kAJjWGKfr6kgdNMwzc5RhQtk+CfjzE02e1pT
    VeDMSr87Id7jVBImNXapZGdb69dwBFIpQNtBNwHJVC+jEY/5+5E/wGixS6FKVl/ql4IW
    P9rxFwJ7hwVCrKlMOrBmwGWfsAlh4D2+McCisjtf99yjeXtdTVoz4pExyQ8oqdUnB+Q7
    +ezwGzH13K4L9TSiVv5WF3vq+ppwE5JJL7OqMHnQLZzowuefdEyP9PZBgpyAXvqrAcmG
    AnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H3GVY4rOo80d072AzYDnApxbUFHCrw71UzSjXJxfCJI=;
    b=paw4xd41ap+ZZU8yR7UiAxtZN7E27tggRTX4EgduD3hJiayLBkWuhDsyqk9DeoptNl
    ptJR8uWm+9pfB5mt4fMxLWSmFmAA7uArKn5IRdW3T3hl3a17xiL5djVoW9c8CrZT8tyZ
    xa0DZdPxnzA5Z8RxlxfOPGraY9SmsGAPmMTUhl8v6HwZ+yHhXZ1xOu7nkZg5SNJvQzOg
    9QA1BwOze8Q1hZ51LYLzjVZ0vAQJeTrMVR/YSRSaiHFPZ9am7iZs0kHAMiTxBpbEAzKV
    S+5XPb8sKBcIDNquoBg69DlbrfbpdenHIty3bzQAjZJfUEA8aNjaRWZlPYt+nmOWnVvO
    8PfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H3GVY4rOo80d072AzYDnApxbUFHCrw71UzSjXJxfCJI=;
    b=i8FcN3CGLwycTTUARwSH9xHIyJmWXLFDaMdWtAEjbzetGhX/qjgy1yZen44QxmBUY2
    VgOg2P1RInwi1G5pZQmE3U5Veacs21y1DE/xHMz4Ot2vSc9idMHd4nC07r+ZhsuLPFtB
    NWMyT+hffBOW6B56JYWgWxSMgjyafYiHnB4XzDDwALSE30OQCNar4yns+B+wkhNuMJOP
    wKIzqfX4uXczYT8kE590ZPa+1WY/399whunVV5z6FIFgfojCY6OxFU/fZPZP24nwFxlU
    IK4Hwun/cU4CpkCkZsWJFRMqB1TiLdglKgDELznbai0qk4VvBZD8KmJvihxqBrxD/cnZ
    qCig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H3GVY4rOo80d072AzYDnApxbUFHCrw71UzSjXJxfCJI=;
    b=DYD9nC/q25YKS/m5e3L22//EIhRlJjUJAzjI4cbbCYXaZ738pHkS4W+ipVWw9TKqmD
    64lPe8J1gXQdmXnZEMDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 50.2.2 AUTH)
    with ESMTPSA id K0cc6102IAl98Tr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Mar 2024 11:47:09 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Guy Harris <gharris@sonic.net>
Cc: wireshark-dev@wireshark.org,
	linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 3/4] socketcan: display len8dlc content for Classical CAN
Date: Mon, 18 Mar 2024 11:46:42 +0100
Message-ID: <20240318104643.24098-4-socketcan@hartkopp.net>
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

While the Classical CAN frame can transport only 8 byte of data the
4 bit data length code (DLC) has the ability to have a value range
from 0 to 15. To be able to send and receive DLC values from 9 to 15
the struct can_frame contains an additional len8dlc element which
can have values from 9 to 15 when the data length value is 8.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 epan/dissectors/packet-socketcan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/epan/dissectors/packet-socketcan.c b/epan/dissectors/packet-socketcan.c
index 2e29484085..4ca0479f79 100644
--- a/epan/dissectors/packet-socketcan.c
+++ b/epan/dissectors/packet-socketcan.c
@@ -33,10 +33,11 @@ static int hf_can_infoent_ext;
 static int hf_can_infoent_std;
 static int hf_can_extflag;
 static int hf_can_rtrflag;
 static int hf_can_errflag;
 static int hf_can_reserved;
+static int hf_can_len8dlc;
 static int hf_can_padding;
 
 static int hf_can_err_tx_timeout;
 static int hf_can_err_lostarb;
 static int hf_can_err_ctrl;
@@ -720,11 +721,12 @@ dissect_socketcan_common(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, gu
 
         if (can_packet_type == PACKET_TYPE_CAN_FD) {
             proto_tree_add_bitmask_list(can_tree, tvb, CANFD_FLAG_OFFSET, 1, canfd_flag_fields, ENC_NA);
             proto_tree_add_item(can_tree, hf_can_reserved, tvb, CANFD_FLAG_OFFSET+1, 2, ENC_NA);
         } else {
-            proto_tree_add_item(can_tree, hf_can_reserved, tvb, CANFD_FLAG_OFFSET, 3, ENC_NA);
+            proto_tree_add_item(can_tree, hf_can_reserved, tvb, CANFD_FLAG_OFFSET, 2, ENC_NA);
+            proto_tree_add_item(can_tree, hf_can_len8dlc, tvb, CANFD_FLAG_OFFSET+2, 1, ENC_NA);
         }
 
         if (frame_type == LINUX_CAN_ERR) {
             int * const *flag;
             const char *sepa = ": ";
@@ -853,10 +855,12 @@ proto_register_socketcan(void) {
             "Remote Transmission Request Flag", "can.flags.rtr", FT_BOOLEAN, 32, NULL, CAN_RTR_FLAG, NULL, HFILL } },
         { &hf_can_errflag, {
             "Error Message Flag", "can.flags.err", FT_BOOLEAN, 32, NULL, CAN_ERR_FLAG, NULL, HFILL } },
         { &hf_can_len, {
             "Frame-Length", "can.len", FT_UINT8, BASE_DEC, NULL, 0x0, NULL, HFILL } },
+        { &hf_can_len8dlc, {
+            "Len 8 DLC", "can.len8dlc", FT_UINT8, BASE_DEC, NULL, 0x0, NULL, HFILL } },
         { &hf_can_reserved, {
             "Reserved", "can.reserved", FT_BYTES, BASE_NONE, NULL, 0x0, NULL, HFILL } },
         { &hf_can_padding, {
             "Padding", "can.padding", FT_BYTES, BASE_NONE, NULL, 0x0, NULL, HFILL } },
         { &hf_canfd_brsflag, {
-- 
2.43.0


