Return-Path: <linux-can+bounces-401-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F387E7A6
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 11:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F61C1C20FA8
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 10:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472102E644;
	Mon, 18 Mar 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HZoAioJ2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="o+mLyqfj"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685612DF92
	for <linux-can@vger.kernel.org>; Mon, 18 Mar 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758842; cv=pass; b=sgz1sqODs5ffEj2VeQJBl1rUy3abYz/Psi16qa+wRPawvfCxzQKPm97ml70iqyDYMdztOK+uBJ43wGU23R+zGCO6XMt6Tw+bcMriVqLA0SpoKimF2Te7Y0Hsd01Td2LW6HjByMS8ixgrJBCulZl8vAzBIHX9DkMHdTr+joNrS0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758842; c=relaxed/simple;
	bh=qHU8hULWinA+2WQ+M3zMT1xweP4x0/wD0nivR9bPEKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjM/g1ji5P7/8IqdNSOZH7sdJvlM4VrDfXmkmhmPYM3q2aHQxSi7OMid3J9maAFKVrITY/kpFu/SkwtP4EUiL3pX5n5HNNUNU84JoGod3MdOBU52lQoCqZuk+MVaEnbzSrULFNx1N9ysYN5TOXwNcMsHXUmkvJtwBFvE39/YXpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HZoAioJ2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=o+mLyqfj; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1710758829; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nIwXFfFzwW8PzycEpCU47+3Txjo6+yXxE145ef3KAKS5SP+w0G5f7FCPTVRR1hAF8l
    x9BZ7opD30Lx651uvsmezeeqcOipXlK1ISYez8jPlp9syk1wloWgzO25d+A/rCkH8DEs
    QFb5lJFQmzqXg8rSixZqISg8DYZsAlQVkB8vxQc1Ppta03zdK7I5pQNOaAU+Xutn5PBv
    ZyUwQpdc2c0HXhROpuk7nuLhpQnW5qg0el3y8R0Xii0/Fje9KCRIzhT0D+UuLiZBTERN
    ROpiWv1Xai6Yj4Dt6HzL7CGAagJei27Ymihg43Ujsp6sP+TXjVOUH1uY5yk1BRovY3NL
    6NeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ojzVciQjPVAv/TxAqtx0OA4Ge2KrFeUyLFJz0VNjKSo=;
    b=dwqlcu0ajh+dGHXBmCwfU7K/HLX09yYgNtDAzKzKIoTogZlUC390UDSObW4+5S1UUd
    Q4FkMGlWdkWlivl7LU1Oxbbsc7w7aO39SOjKKvu+joxEPc6qkYjU6qvumtkGyg8UItcG
    l819ClIZxR5SW9E48LK5fxzhG3G87uCC11Pf38JtAZTwiVUk/CEcVHDq52gYpzXxzx+P
    dJ8luYNQ+vSPO4fxXfijQPAGZzoFs/NqKpbhnZZiLTgO2WoL1/5948SVX9tfeu5nyqMb
    EOr8dq6jmJivoaPmyNSfLw+ITa4Q5xssWOI/Ihdk985oqRTu6x5L55KMTvybSUf4+h1a
    4oxg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ojzVciQjPVAv/TxAqtx0OA4Ge2KrFeUyLFJz0VNjKSo=;
    b=HZoAioJ2L8WJ7TQHUYEjAS92u3uQrytuUs3uTOhntr2Lxu+Ym7PJfY+txeKwJ2VYAc
    UwsxuophaG+dK9UaVp3WYPba5Xyt6PKnsiQg3hjnQclJ1C9sO7jKAkigYCaT+gCTwfOa
    iVyD7Cn9L3UEJj/vPOo0QaBpYMPm05B+Tit074JOXVc1PKoN2nb8rGZKITIekXYCHm5l
    cjlQp5pwvr6yz/tc43y0n39GgcMOiCSM2+1bLRVolpQmKRYwwvkybhDFCadCZBb0Zr4g
    hy9eRCM9T6LCtJIO6o9Pg2+Phj5hrhOQsnPl49Vyrn2PCwEyG07LnO31IGtbczvG+niT
    aksQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ojzVciQjPVAv/TxAqtx0OA4Ge2KrFeUyLFJz0VNjKSo=;
    b=o+mLyqfjdbyWSo7c+cnq5dDIzzuU+jhbXhyCX5QPf6W3Cfbp9zagW+/XSTCyM/utXp
    LU43343OzveQe+JvOWBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 50.2.2 AUTH)
    with ESMTPSA id K0cc6102IAl98Tp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Mar 2024 11:47:09 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Guy Harris <gharris@sonic.net>
Cc: wireshark-dev@wireshark.org,
	linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 1/4] socketcan: simplify CAN packet type detection
Date: Mon, 18 Mar 2024 11:46:40 +0100
Message-ID: <20240318104643.24098-2-socketcan@hartkopp.net>
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

The different CAN frame types are defined by Linux SLL_P types in the
sll_protocol field and the length of the frame.

LINUX_SLL_P_CANXL:
The frame length for CAN XL can be 12 + 1 to 12 + 2048 (13 .. 2060) byte.
Additionally the CANXL_XLF flag has to be set.

LINUX_SLL_P_CAN and LINUX_SLL_P_CANFD:
The frame length for CAN CC is 16 byte and for CAN FD it is 72 byte.
Additionally the CANXL_XLF flag is cleared in CAN CC/FD frames.

Simplify the CAN packet type detection by checking exactly the above
rules without checking the CANFD_FDF flag which is not guarantied
over all Linux kernel versions.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 epan/dissectors/packet-socketcan.c | 56 +++++-------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/epan/dissectors/packet-socketcan.c b/epan/dissectors/packet-socketcan.c
index e441c44ade..e9fcdb2dd8 100644
--- a/epan/dissectors/packet-socketcan.c
+++ b/epan/dissectors/packet-socketcan.c
@@ -110,10 +110,11 @@ static heur_dtbl_entry_t *heur_dtbl_entry;
 #define CANFD_FLAG_OFFSET  5
 
 #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
 #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
 
+#define CANXL_FLAGS_OFFSET CAN_LEN_OFFSET
 #define CANXL_LEN_OFFSET   6
 #define CANXL_DATA_OFFSET  12
 
 static dissector_table_t can_id_dissector_table = NULL;
 static dissector_table_t can_extended_id_dissector_table = NULL;
@@ -589,69 +590,28 @@ dissect_socketcan_common(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, gu
     static int * const canxl_flag_fields[] = {
         &hf_canxl_secflag,
         NULL,
     };
 
-    /*
-     * If we weren't told the type of this frame, check
-     * whether the CANFD_FDF flag is set in the FD flags
-     * field of the header; if so, it's a CAN FD frame.
-     * otherwise, it's a CAN frame.
-     *
-     * However, trust the CANFD_FDF flag only if the only
-     * bits set in the FD flags field are the known bits,
-     * and the two bytes following that field are both
-     * zero.  This is because some older LINKTYPE_CAN_SOCKETCAN
-     * frames had uninitialized junk in the FD flags field,
-     * so we treat a frame with what appears to be uninitialized
-     * junk as being CAN rather than CAN FD, under the assumption
-     * that the CANFD_FDF bit is set because the field is
-     * uninitialized, not because it was explicitly set because
-     * it's a CAN FD frame.  At least some newer code that sets
-     * that flag also makes sure that the fields in question are
-     * initialized, so we assume that if they're not initialized
-     * the code is older code that didn't support CAN FD.
-     */
+    /* determine CAN packet type */
     if (can_packet_type == PACKET_TYPE_UNKNOWN) {
-        guint8 frame_length;
-        guint8 fd_flags;
+        guint8 canxl_flags;
 
         /*
          * Check whether the frame has the CANXL_XLF flag set in what
          * is in the location of the frame length field of a CAN classic
          * or CAN FD frame; if so, then it's a CAN XL frame (and that
          * field is the flags field of that frame).
          */
-        frame_length = tvb_get_guint8(tvb, CAN_LEN_OFFSET);
-        if (frame_length & CANXL_XLF) {
+        canxl_flags = tvb_get_guint8(tvb, CANXL_FLAGS_OFFSET);
+        if ((tvb_reported_length(tvb) > 12) && (canxl_flags & CANXL_XLF)) {
             can_packet_type = PACKET_TYPE_CAN_XL;
         } else {
-            /*
-             * This is a CAN classic or CAN FD frame.
-             * Check whether the flags field has the CANFD_FDF
-             * flag set, has no unknown flag bits set, and has
-             * no bits set in the two reserved fields.  If so,
-             * it's a CAN FD frame; otherwise, it's either a
-             * CAN classic frame, or a frame where the CANFD_FDF
-             * flag is set but where that might just be because
-             * that field contains uninitialized junk rather
-             * than because it's a CAN FD frame, so we treat it
-             * as a CAN classic frame.
-             */
-            fd_flags = tvb_get_guint8(tvb, CANFD_FLAG_OFFSET);
-
-            if ((fd_flags & CANFD_FDF) &&
-                    ((fd_flags & ~(CANFD_BRS | CANFD_ESI | CANFD_FDF)) == 0) &&
-                    tvb_get_guint8(tvb, CANFD_FLAG_OFFSET + 1) == 0 &&
-                    tvb_get_guint8(tvb, CANFD_FLAG_OFFSET + 2) == 0) {
+            if (tvb_reported_length(tvb) == 72)
                 can_packet_type = PACKET_TYPE_CAN_FD;
-            } else {
-                if (tvb_reported_length(tvb) == 72)
-                    can_packet_type = PACKET_TYPE_CAN_FD;
-                else
-                    can_packet_type = PACKET_TYPE_CAN;
-            }
+            else if  (tvb_reported_length(tvb) == 16)
+                can_packet_type = PACKET_TYPE_CAN;
         }
     }
 
     can_info.bus_id = get_bus_id(pinfo);
 
-- 
2.43.0


