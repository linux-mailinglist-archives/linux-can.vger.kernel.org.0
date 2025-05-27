Return-Path: <linux-can+bounces-3700-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E92AC5B10
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51908188D20D
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3E20297B;
	Tue, 27 May 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jaZRv13h";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OAGOoNcB"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B137202979
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375812; cv=pass; b=Lb9qZSP8r1sTNfYNIpMTlnLTHeob/VfxAMHwJuHGdenmdnGUik9F+Y9QHlp+5qxS/A5c4FiCUnRKDYhTl6C6EzrUFihkQYBXewp58bU54Lp38eW15oB1DNCNvXgFU6Hb3ZS8Z9g+0XbnQoLmcMePoNaB7dYAv1MZ+dSLy1YjJgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375812; c=relaxed/simple;
	bh=f+r2XWrAths325cIf+LA6pmKNX3pvvluysoHQJ9qWNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+xjzRuKFs9j6SSS54+ecW8xXG8h1yY7FL9yTcDoQu9V9vFrrJdd77aKEzRffGblhdjDZmdE2YD807paZMgWuwsl9EyjVYjsDLjsktWDjlGFC7qXy53o1whl465qpqfIvVIcxYdseSG7iBCcduRIOwan0xrv58zjjFiOMv7Y/hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jaZRv13h; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OAGOoNcB; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375802; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=svrHsSrWZi9yHPdEX6lRzxXAXa3w6EoQpv4VNuidEdp96riFwCldGE3I/rwj3K68iz
    J+ISfbgeXkrdGBuPsI+++bUvZFobWg/abDDEd9ff+ynxkjCdD0y+q5ohS1nJv1o90mLX
    HglO1JG7+Ss7xbDZxU4o8W3Fm1oQBvV9J0AUuMfVfucd/X4TL2mYmtTyDXLE+PQaeca2
    AMhRcofGKls0yhw7F+khXPuYOEtlRiwVgoGFRFoyXDzQPpUN1ta0Sn9jAuN2zgVgPXQ+
    IzhMYdU39cqF/zK81YDAnAQIOamAFzICpWzGgU1vQ//naEX5lc4MS3uYaHcHPCThhbb7
    ejhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dlqXJOk/qhuQPAW3F16SDUxl1H3v2z5VRiINEE5HyH4=;
    b=O24eYhU3hwVJuUnRxY35iTGT9sx71DUFuvYZilBmS0UiPTvLSPpEWCIXGMf+hzGvpt
    Hq2dDljBtFJW2nt80s1QTHEzDhtSQPX+bOFXm5ZzxaWYen2kW1fuah+/BkBi5iabSBb7
    uA8msGwI2fGeXeEWt3GU1H3rP8HKOL2GHmkve//QWHdm+fUjdzDZxaFpw6JJvLFehRRj
    8yYdxFs4Xg4/FJViWHFpoo/b8Mfvxfbu78HEKFVXanCM4PyGsQftk48Ik+SdgTWhJHA0
    HeCyc4KpjrPKe6xVvsfosZTepkvwRSigOvozUTcfZXPoh7SmSYnejj18iNwcDychAH8V
    8VpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dlqXJOk/qhuQPAW3F16SDUxl1H3v2z5VRiINEE5HyH4=;
    b=jaZRv13hoQHAdWL4cSumt6zm5JiGRWik/CFLIP79SUxOmJOJ4pzKThDHDB4LI1e2RT
    9SgZ/LwPzowNGJN1XvOP1xzCvuYSLiqZrWtiJgn68Ncx6+twEVbLYTrpTOKbhmL/NOuc
    g1bROFxsJrhr9XrAAiy71hZB+s0IUKj81UhC0enZ/qUzj2i04vWklqjD7wcrLvct8+hn
    bNhYQgV+HK88snUA03pzeasuzz4ejZQ3VnftxE9SbTm8giv02U3O5L3v+kad5nwtWS+u
    zV+KahFiNO0nfLoHKJBNPYr8NouoXDgEsdbff40w/qXbhZ0GMb7lRQ2OW/LgPFV5wcmw
    i+Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dlqXJOk/qhuQPAW3F16SDUxl1H3v2z5VRiINEE5HyH4=;
    b=OAGOoNcBegowRCtGgU3QILin7QdvL6+1BT/bW3Ctl91pvp678msxK5lc2BB8usyQcF
    Fe3qrXpILlmTpf1ZbPAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJugiW9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:42 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 07/11] can: canxl: support Remote Request Substitution bit access
Date: Tue, 27 May 2025 21:56:21 +0200
Message-ID: <20250527195625.65252-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195625.65252-1-socketcan@hartkopp.net>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The Remote Request Substitution bit is a dominant bit ("0") in the CAN XL
frame. As some CAN XL controllers support to access this bit a new
CANXL_RRS value has been defined for the canxl_frame.flags element.

To read/write the Remote Request Substitution (RRS) bit in the CAN XL
frame the CAN_CTRLMODE_XL_RRS has to be enabled in CAN driver.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index f4fb8eea8f35..55b8374ab094 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -104,10 +104,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL_RRS		0x4000	/* XL enable RRS bit access */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
-- 
2.47.2


