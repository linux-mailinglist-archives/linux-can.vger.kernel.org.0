Return-Path: <linux-can+bounces-2663-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75159A16D87
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 14:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBB4168A38
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8581E1A1F;
	Mon, 20 Jan 2025 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brixandersen.dk header.i=@brixandersen.dk header.b="pSeyU8pz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="stgp4jmV"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA31FC8
	for <linux-can@vger.kernel.org>; Mon, 20 Jan 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380395; cv=none; b=gsEaPczoVlkex9mPgkUODE04xXNEAH5geHfiENgunX5n53N+nhoEZnWfHsAEOlzkPgHmIWDbhYeTlEHDQmNGjTzKAOmwuxYnbTYyQNMSdSjYtO/tVw7uGNY1wWEp3dNznDSYiGB19Jmt6KfbeBavM9Mj9FtJE6jr68ONqYXoJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380395; c=relaxed/simple;
	bh=B78CnXPderqvwR/YbCn4jrXF6H4hXYg4VhZ3i6vu4lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J2KU3B7Or9DJgNovVWWRC7LjkG2zDBRbs8W2y97YPdeZJt5KVOe7OJf+Spu4wp71vhUFG8FjS2JhD2cMI7OvMndECIaXwnXLNHiveeQPPbd6pb+ALnVQwaK+v+Aa3CTNWUkrWvIORBGaTtxiaQ7J/4swG4tJXM3ATtlc3iIchoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brixandersen.dk; spf=pass smtp.mailfrom=brixandersen.dk; dkim=pass (2048-bit key) header.d=brixandersen.dk header.i=@brixandersen.dk header.b=pSeyU8pz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=stgp4jmV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brixandersen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brixandersen.dk
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E60D413808CD;
	Mon, 20 Jan 2025 08:39:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 20 Jan 2025 08:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brixandersen.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1737380390; x=
	1737466790; bh=O3NtCit1gAc2mvHiMTrXvPD2qaDU6yBAvC132bQL8Qw=; b=p
	SeyU8pz/pDyjWtPLpzlvTX+rKNRZx8SwW3rDAbMO9ieEPAEdMh0i29ue3dSn+usT
	3wDo7ljaD9fkn7rPt8gOpr6K+zomIuAaxkxJ2OJFPZEIT37c1K4Wt2MHWgf+/yWD
	bAQPGCWPQ46svXbJnHQ+kUJfTUAK4IpqLXXObaeoenmYubLyiplPxW9WT17W6rBH
	Z9Du3BlVxoKutTQbEcDrEkdvhbcXKJ3it6VSIPl/VSshrFQcmEL9PXJxOq0gd9Hn
	X+M1JOk/lvVfcuER0UNgMS8DsR/ECwSdaGz6Lab5hkjmgzDXfVUbC9cb56fK+0Kr
	aBzc5rd5WZZ94HNt05hXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1737380390; x=1737466790; bh=O3NtCit1gAc2mvHiMTrXvPD2qaDU
	6yBAvC132bQL8Qw=; b=stgp4jmVSxqzME0Dk2rUaB7YDnbVbnPdMnsTZCig3Sqw
	G5zwSWjPVvfb328Ibk7TsSQ9LhmwtTZPaxdIrX4t7NwadnJTBt0BL4ClvT/bJ66V
	Q/RyVaUAt9S5SEtxKoO0hl3Bgh+xnQKFYAmi6JUhuQ8ZWzJAexm3NCI8xX/xs0g6
	q+8HqKz7ak2VSOoGBaIYHM/cddK/IhkLvJ6V//S04fe1JkfrPOW5QdKyBKGn77OW
	iytmKO4vkTL84kFWGHwiWRO4DOndy8YC2sZWnQ80b7yds9YK8xPYGp60S+bfAuoE
	EKGgP1tvhuDtSLBTOM7BdTnsAVep31t691fBvhCa9g==
X-ME-Sender: <xms:JlKOZ1mxyOekqTBbafMKyOFRlGdItcR7Z7wWbfqf8CZfIS9o3XEP_A>
    <xme:JlKOZw2Vy_NlKLGDVgz_IvR8FUjdHo09r8jiFQyIc6wa9B0bK883OdSU8QdqiPb1G
    ijnxxdq6MbU1aafdw>
X-ME-Received: <xmr:JlKOZ7p89FrpisEllGV2mAEM1DX5QngTS62qyuIQTnQ04m3Kt4IQ2UUxmPSPN-UkqzeT7WIr4fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepjfgvnhhrihhkuceurhhigicutehn
    uggvrhhsvghnuceohhgvnhhrihhksegsrhhigigrnhguvghrshgvnhdrughkqeenucggtf
    frrghtthgvrhhnpefgfeevveegheehkefhfeeijeejfefgjedvuefguedtleegledtueeh
    ieduledvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehhvghnrhhikhessghrihigrghnuggvrhhsvghnrdgukhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqtggrnhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghnrhhikhessghrihigrghnuggv
    rhhsvghnrdgukh
X-ME-Proxy: <xmx:JlKOZ1mjg-7sD-o4gZVwfcsWIx8jbnGjEN4nT000t3kxT7vPCqeTRw>
    <xmx:JlKOZz1HHtOw059mrlCTvJ1bYJmvUWxPshTk45xLB79u9MZxucTAtw>
    <xmx:JlKOZ0u_Bysc9oXP3uIkylkEJsQiu5XsK10fEXPeItrTIzrc4MGRyw>
    <xmx:JlKOZ3Vm6x0B-JX9UoeVSk4n_o-MtT16x3hVIm0SnK3XWlYvtNYhRA>
    <xmx:JlKOZxAfwvBU0Dwoa1kimvT2alitmOuoRNnL2uLY0lGSj8gLVMuTho_W>
Feedback-ID: i203040d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 08:39:50 -0500 (EST)
From: Henrik Brix Andersen <henrik@brixandersen.dk>
To: linux-can@vger.kernel.org
Cc: Henrik Brix Andersen <henrik@brixandersen.dk>
Subject: [PATCH] can: gs_usb: add VID/PID for the CANnectivity firmware
Date: Mon, 20 Jan 2025 13:37:59 +0000
Message-ID: <20250120133827.668977-1-henrik@brixandersen.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add USB VID/PID for the CANnectivity USB to CAN adapter firmware.

Signed-off-by: Henrik Brix Andersen <henrik@brixandersen.dk>
---
 drivers/net/can/usb/gs_usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b6f4de375df7..3ccac6781b98 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -43,6 +43,9 @@
 #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
 #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
 
+#define USB_CANNECTIVITY_VENDOR_ID 0x1209
+#define USB_CANNECTIVITY_PRODUCT_ID 0xca01
+
 /* Timestamp 32 bit timer runs at 1 MHz (1 µs tick). Worker accounts
  * for timer overflow (will be after ~71 minutes)
  */
@@ -1546,6 +1549,8 @@ static const struct usb_device_id gs_usb_table[] = {
 				      USB_ABE_CANDEBUGGER_FD_PRODUCT_ID, 0) },
 	{ USB_DEVICE_INTERFACE_NUMBER(USB_XYLANTA_SAINT3_VENDOR_ID,
 				      USB_XYLANTA_SAINT3_PRODUCT_ID, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(USB_CANNECTIVITY_VENDOR_ID,
+				      USB_CANNECTIVITY_PRODUCT_ID, 0) },
 	{} /* Terminating entry */
 };
 
-- 
2.43.0


