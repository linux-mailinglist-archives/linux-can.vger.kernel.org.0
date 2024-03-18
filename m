Return-Path: <linux-can+bounces-402-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE1187E7AB
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 11:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ACC1C212ED
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950442E827;
	Mon, 18 Mar 2024 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Dl5FGBYF";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nfQhKVMS"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF732C6C
	for <linux-can@vger.kernel.org>; Mon, 18 Mar 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758990; cv=pass; b=A7zK8RjRc8eNbwME4K10Bc0e0PDayRiLh/iElV2YCtjL4AJJPWdGia+55Y8P7N9IaUGRt63IW0gtlcGC+jAE2KaCKW+7mF5HRsllbLZe2RZo0MZNjJCI7sK70vC9qOPPAms6bDZKBsg8a2yFmfZC5wq5deXlCQGHrfPTFzgUHQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758990; c=relaxed/simple;
	bh=7jiStVjzFQLL5YpfEGI67cI98Ysi2z6/aVesRdn3HK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kb/rdItJRxByAKVLGlu8IeNIqPChCwrNmD0lql6WusqozUtkw3MMQ2UGhJIJ2gwudoG5a22p5V/2ry8hGn+4MOc8+mMCF9eBbl7MhjA7s1YTwvhp70cOKWBRvoM4uf3gkFYyKsCJ0lvrSJcTN/nsz7kEbU+lPyOkrGkT/+GQ5ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Dl5FGBYF; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nfQhKVMS; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1710758980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UY/lCYLS1/iihc3Ph9lNXzWpW5TlIeVbmAXur/qzRSK7rfaroJwYK0evC4CRy2QIDq
    2/q4DVOaBXk9FH/4EoCToTdVn42aZ9DX3YF5dstUbzV3zaWTyjsbbbOoIf9rtCJjnExD
    iQuaXywQWEifJFloadEs5tcEFUyK5TE91xopf8kXTWr7gTdpCWSbRUofBd2MqsyJARcs
    +PoFrbL3RhVi1jenjWsUc23XP6hrwkQZh6rAPUmHa60URoMMKK02eNrjT5VOPK32Bisy
    AJNH473/6TY4JAa4h/nrhdRT8dtLXj//UvlO9tSa05BhnyKoQce27kcedu0Vv3IFgQqa
    JvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758980;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LJuaUUYQRi+zvqrESpF/BtyposMvIu71EcWZ53o3dDM=;
    b=VxvOKc5mIuo1ypRIiwXsGXJKWpGoo60gGPYOEIeL/FqJl0SoLD74kSaSrVD5Qz/LcO
    JfvlcL9OjwH0sg1yevusdFa19BtVHDqyTbUDVFAX90LT2cwqgGcVjHvvYQtk31xKkK1/
    00XuB9ZpHy9fCz5VdgeVhfdB+Q5VKM/HIHmvxLx0nSR6ZNOGQQJLvJIc9knXGZdtr+5n
    CxO5B6D9bgAr3a9Jt9lQJvYgecMi4MzXEvx13uW2+iKnAk5KPA0syK8dkrvUSGdRoURa
    xhORqQGOhl5LDpliuOrFY8tddM6hmYuQ//cBtyxTc9IB4PdedQ4VXA+P+pE3JK2gl7sU
    W7zQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758980;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LJuaUUYQRi+zvqrESpF/BtyposMvIu71EcWZ53o3dDM=;
    b=Dl5FGBYF/91TJKKAQypu2irMObNQBymD5w92cB3d39O1II7mLkITVu1f8z3nS8qIjL
    /rfukJuGECL+Aqs7oqqq81CaOl7qbJCGp1T8cPj/K03CFgTTfw5t44s1mt7Rvfxp0xcq
    IhLDwqO1WKxRU3o6/ZHNO8hzkxWZ4W3TJejNrrxmoH8pbQii8PRcu+5Na/v7cOpfjLDC
    hOVz45bAKFjF956a1aLT62WilTIPFX2arYMdDjS7aVxMPj1ao+XnmTTXZuY1QaukMfoY
    Olst5cn/EFb11j707IpVs1jpNyAxDoLOrJDFPM2+QjB+nZqTu7sM7Hk4bWMd78aOCd8M
    3xKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710758980;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LJuaUUYQRi+zvqrESpF/BtyposMvIu71EcWZ53o3dDM=;
    b=nfQhKVMSbFC2xk/IFL6VNHwddJGBUaH2+WQa/wHTFAoBdQMR4CMAtaJsT3JcWq67VM
    hG18kZcgEI7g3qT2TjAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 50.2.2 AUTH)
    with ESMTPSA id K0cc6102IAne8Ux
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Mar 2024 11:49:40 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Guy Harris <gharris@sonic.net>
Cc: wireshark-dev@wireshark.org,
	linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] socketcan: make CAN CC/FD/XL frame handling less invasive
Date: Mon, 18 Mar 2024 11:49:33 +0100
Message-ID: <20240318104933.24194-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.43.0
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

Reduce the modification and 'sanitizing' efforts only to the above
requirements to be robust against incompliant content which might be
provided via PACKET sockets but do not manipulate further content.

This helps to identify uninitialized data and to support new features
in formerly reserved structure elements without changing the libpcap.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 pcap-linux.c | 98 ++++++----------------------------------------------
 1 file changed, 10 insertions(+), 88 deletions(-)

diff --git a/pcap-linux.c b/pcap-linux.c
index c6516c19..0afd75eb 100644
--- a/pcap-linux.c
+++ b/pcap-linux.c
@@ -3960,103 +3960,17 @@ static int pcap_handle_packet_mmap(
 		 * type is DLT_CAN_SOCKETCAN.  Fix up the header
 		 * provided by the code below us to match what
 		 * DLT_CAN_SOCKETCAN is expected to provide.
 		 */
 		if (sll->sll_hatype == ARPHRD_CAN) {
-			pcap_can_socketcan_hdr *canhdr = (pcap_can_socketcan_hdr *)bp;
 			uint16_t protocol = ntohs(sll->sll_protocol);
 
-			/*
-			 * Check the protocol field from the sll header.
-			 * If it's one of the known CAN protocol types,
-			 * make sure the appropriate flags are set, so
-			 * that a program can tell what type of frame
-			 * it is.
-			 *
-			 * The two flags are:
-			 *
-			 *   CANFD_FDF, which is in the fd_flags field
-			 *   of the CAN classic/CAN FD header;
-			 *
-			 *   CANXL_XLF, which is in the flags field
-			 *   of the CAN XL header, which overlaps
-			 *   the payload_length field of the CAN
-			 *   classic/CAN FD header.
-			 */
-			switch (protocol) {
-
-			case LINUX_SLL_P_CAN:
-				/*
-				 * CAN classic.
-				 *
-				 * Zero out the fd_flags and reserved
-				 * fields, in case they're uninitialized
-				 * crap, and clear the CANXL_XLF bit in
-				 * the payload_length field.
-				 *
-				 * This means that the CANFD_FDF flag isn't
-				 * set in the fd_flags field, and that
-				 * the CANXL_XLF bit isn't set in the
-				 * payload_length field, so this frame
-				 * will appear to be a CAN classic frame.
-				 */
-				canhdr->payload_length &= ~CANXL_XLF;
-				canhdr->fd_flags = 0;
-				canhdr->reserved1 = 0;
-				canhdr->reserved2 = 0;
-				break;
-
-			case LINUX_SLL_P_CANFD:
-				/*
-				 * Set CANFD_FDF in the fd_flags field,
-				 * and clear the CANXL_XLF bit in the
-				 * payload_length field, so this frame
-				 * will appear to be a CAN FD frame.
-				 */
-				canhdr->payload_length &= ~CANXL_XLF;
-				canhdr->fd_flags |= CANFD_FDF;
-
-				/*
-				 * Zero out all the unknown bits in fd_flags
-				 * and clear the reserved fields, so that
-				 * a program reading this can assume that
-				 * CANFD_FDF is set because we set it, not
-				 * because some uninitialized crap was
-				 * provided in the fd_flags field.
-				 *
-				 * (At least some LINKTYPE_CAN_SOCKETCAN
-				 * files attached to Wireshark bugs had
-				 * uninitialized junk there, so it does
-				 * happen.)
-				 *
-				 * Update this if Linux adds more flag bits
-				 * to the fd_flags field or uses either of
-				 * the reserved fields for FD frames.
-				 */
-				canhdr->fd_flags &= (CANFD_FDF|CANFD_ESI|CANFD_BRS);
-				canhdr->reserved1 = 0;
-				canhdr->reserved2 = 0;
-				break;
-
-			case LINUX_SLL_P_CANXL:
-				/*
-				 * CAN XL frame.
-				 *
-				 * Make sure the CANXL_XLF bit is set in
-				 * the payload_length field, so that
-				 * this frame will appear to be a
-				 * CAN XL frame.
-				 */
-				canhdr->payload_length |= CANXL_XLF;
-				break;
-			}
-
 			/*
 			 * Put multi-byte header fields in a byte-order
 			 *-independent format.
 			 */
-			if (canhdr->payload_length & CANXL_XLF) {
+			if (protocol == LINUX_SLL_P_CANXL) {
 				/*
 				 * This is a CAN XL frame.
 				 *
 				 * DLT_CAN_SOCKETCAN is specified as having
 				 * the Priority ID/VCID field in big--
@@ -4085,10 +3999,13 @@ static int pcap_handle_packet_mmap(
 				 * frames were captured are likely
 				 * to be little-endian processors.
 				 */
 				pcap_can_socketcan_xl_hdr *canxl_hdr = (pcap_can_socketcan_xl_hdr *)bp;
 
+				/* ensure CAN XL flag for CAN XL fame detection */
+				canxl_hdr->flags |= CANXL_XLF;
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 				/*
 				 * We're capturing on a little-endian
 				 * machine, so we put the priority/VCID
 				 * field into big-endian byte order, and
@@ -4118,19 +4035,24 @@ static int pcap_handle_packet_mmap(
 #else
 #error "Unknown byte order"
 #endif
 			} else {
 				/*
-				 * CAN or CAN FD frame.
+				 * CAN CC or CAN FD frame.
 				 *
 				 * DLT_CAN_SOCKETCAN is specified as having
 				 * the CAN ID and flags in network byte
 				 * order, but capturing on a CAN device
 				 * provides it in host byte order.  Convert
 				 * it to network byte order.
 				 */
+				pcap_can_socketcan_hdr *canhdr = (pcap_can_socketcan_hdr *)bp;
+
 				canhdr->can_id = htonl(canhdr->can_id);
+
+				/* make sure the CAN XL detection is not affected */
+				canhdr->payload_length &= ~CANXL_XLF;
 			}
 		}
 	}
 
 	if (handlep->filter_in_userland && handle->fcode.bf_insns) {
-- 
2.43.0


