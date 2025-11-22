Return-Path: <linux-can+bounces-5599-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 865FEC7CBDC
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7436F4E3EDD
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E80221F0A;
	Sat, 22 Nov 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OqiToAyW";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I8TdXL0Y"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB72F5A18
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804186; cv=pass; b=j28jQ93+L63jtbL0DxfKFOqY3+3L86k6T/gsns9AntbP4sg7Bl5+opnn6THx79MmWyPLvUqgJ0jUKWD6UKrX75nDaSTNk6NI/HS5z2zCJwfUrDcz6m8wndyg6Wj5vWANuegkJTVLSUCzxRjytDXXbSWbRKIqszSkLquzCiAF970=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804186; c=relaxed/simple;
	bh=m7EeSy2+xKqgnXdooRw95j4Mc3UdRErVYKrMnhFrMio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdIzNlDal273w+mX+V5L2dlCr4LlZQyNZkE+JTAagzWVsBTOb0MZ6+seG1OSSe/fCPkX9ossnLAP+jbhxuiJ6LlaUN8+IFdzx3chA6HiGu+OlBLFbxKp5kbX2+C4c/JDjyIXmBhPU//CQmn/hHLbH3i0cd2mU9m7Fs1rB6+a1/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OqiToAyW; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I8TdXL0Y; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804173; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kQkQcCGyvZIOj6LiAhliQyfk/NXvGUHV7ij9xmGjk9WwyuWmLsRQKxhh7ahJ9JOVOS
    5pinZhSCY4AnNZoJGPzd2Almk/PjCpoLGtDSTOb4YX7p78KIykCl+oTsOcDBLvtRtQcO
    srGUZUJRw9hkKqy+1cwQid9zyDGghaXQBKM249vrPhc99rVTb2Tr1oNVlx95rfiZarZi
    bGeE7Nu0QH5GBrgmE4iYDS0O+wwaFvrxKkOZKDS8PJA+gqdZQ3KT6sQ+8K9Fhspew4d3
    L/y9+mFND+CMfql0THGe6hD6LshCySKzjGGM6Cn9akjWlxHJZzvIuVdTQqnfEc7V/fVi
    tVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804173;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mv4MJQA7KSzTFdvYxdDLGEQT/672EB+06RsOc+u97Q0=;
    b=ITIri7pfe+YYP3Og8b1XIRjg7HFUxWP7DFJKwSeyVC5E9pDzzWlj8s3UbwkEB0DVaA
    RCwGjMuf/bGL0knRjAl+03PtZXc5hgpnBII2hoEXzhCiltDp8GQntnfWooZ5RBXVMeDO
    z+uXLI35yMHPxaybP8pu5mYeTymZCLXS/Ee1Om1NbOBfDsumlobe2URsesN6YCMfilEl
    5rVstiR6Aiu0bXAY/2qaWdmTvWjVUK0SYe3UYaUv5jZ2Rq9iVtY62nB3jmhb6I08IHow
    cw+NsFlCk+VCwADbkipUUC9H7hG/5N30JOG9uiIGqyRNNHiF+y1ZnsGzWo58OmWeJ0Ag
    oZEw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804173;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mv4MJQA7KSzTFdvYxdDLGEQT/672EB+06RsOc+u97Q0=;
    b=OqiToAyWV3LYC4fJq9RZK0+7hPDaOyuSsSImia8fooJ6D2sgsEfiC5fgkFnZ06cV8R
    n1F0n4V/oHluAk+0As8U4MclVaggwliAERgKSlzqtpBJHRyqBQ+xn+vqm/FVS5JvEiL5
    4qp+2Web2IEtP0B8A3Hl2nM5ezkrNDPZDmriOJdPef1nw6qlStCF6u5/eLkyyqGvkU+G
    KL6eKYtmq5sQcS6XGNPLW/X/ZaWG/ADLJJ7kh1hAbLdjqcvQRAlBcMdHEswEPnY5HDJb
    cEGX1dDsTZpv9Y/rQlU/1ZkPF0XvpcwZLe0PuIcL3/TfOhFeRx2jASWCCr4aXIm/boJN
    JD2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804173;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mv4MJQA7KSzTFdvYxdDLGEQT/672EB+06RsOc+u97Q0=;
    b=I8TdXL0You7cSk2nGB8ymi927hArW1EyQinE0ptj4HFoJTm345qgtoFPeen67QdQRq
    HIkB63fNKy1gC0Y68JCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9aDFe1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:13 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v6 17/17] can: dev: print bitrate error with two decimal digits
Date: Sat, 22 Nov 2025 10:36:01 +0100
Message-ID: <20251122093602.1660-18-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Increase the resolution when printing the bitrate error and round-up the
value to 0.01% in the case the resolution would still provide values
which would lead to 0.00%.

Suggested-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/calc_bittiming.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 0b11c4e98172..e232993a5138 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -150,23 +150,26 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		if (bitrate_error == 0 && sample_point_error == 0)
 			break;
 	}
 
 	if (best_bitrate_error) {
-		/* Error in one-tenth of a percent */
-		v64 = (u64)best_bitrate_error * 1000;
+		/* Error in one-hundredth of a percent */
+		v64 = (u64)best_bitrate_error * 10000;
 		do_div(v64, bt->bitrate);
 		bitrate_error = (u32)v64;
+		/* print at least 0.01% if the error is smaller */
+		bitrate_error = max(bitrate_error, 1U);
 		if (bitrate_error > CAN_CALC_MAX_ERROR) {
 			NL_SET_ERR_MSG_FMT(extack,
-					   "bitrate error: %u.%u%% too high",
-					   bitrate_error / 10, bitrate_error % 10);
+					   "bitrate error: %u.%02u%% too high",
+					   bitrate_error / 100,
+					   bitrate_error % 100);
 			return -EINVAL;
 		}
 		NL_SET_ERR_MSG_FMT(extack,
-				   "bitrate error: %u.%u%%",
-				   bitrate_error / 10, bitrate_error % 10);
+				   "bitrate error: %u.%02u%%",
+				   bitrate_error / 100, bitrate_error % 100);
 	}
 
 	/* real sample point */
 	bt->sample_point = can_update_sample_point(btc, sample_point, best_tseg,
 						   &tseg1, &tseg2, NULL);
-- 
2.47.3


