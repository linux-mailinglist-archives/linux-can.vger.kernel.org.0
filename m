Return-Path: <linux-can+bounces-5524-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3770C75F8A
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4A3A12FDF1
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E2F1A3179;
	Thu, 20 Nov 2025 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Wo8fVrHD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QmzB8btC"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD01274B42
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664343; cv=pass; b=ZmEnyV1927dRB5dl5TMmjzxo+aNrTrJ35ICOXkWDPb/H+qsUeWZr9c39e7jjZ6nuxjk9ow6x9mCzW8PveNoPpLtMmxHOCgDWDK/aB1fFDWDyr4S+vFQz3GEmOs83hBYtEYCQHikwgx55SP9oOAhSSUyXOQzLl79DdZ0dA37iUGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664343; c=relaxed/simple;
	bh=mgqTLbAwocvVUx/vzjnmomF8tzGvuantr0UvBDMh2RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXY0/PTAWsj0jdenu999I2z3K24Fm13HP+pNmGjtWLDASu1ISStHRtxX35hw5fkdbL9T5XgAafRISZsp6zzaJnwPBd5jyLWVz8pbTFgnxhSJo0ggCn8JRW+8VLvkq23hCJTTHHGtwi1Fo4B7faAlRGw2NAVKlCME6fCULd1KspI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Wo8fVrHD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QmzB8btC; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664325; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=K7wnvYPSQd0aoBzXF1ZgXMVAcNVf3Q5u6Z17ujcM0ZnpA2ciG0maoKqaYlkGeA4k/8
    k2IjjstuIGFDzah9HdhYLARUvBcpQ07XbfTeYhJgk21LJaboH7gA2P6HCrQtHS0h6wwY
    WVoIQUowcZItWNjk9g1uZJNeQdDcsd5YM9nEmskGstIdksql1BeoFfCkvmLmB0xzNCFh
    abvNioYx9XSGi8fK0Nn/tKvorzuRcxZww1lSEjdQnsaMgrtu8wpi7PfWeP5iKD+Ueu1e
    +FZEAU5lbXF67rhzODDhfapnE01JyAQUnEHftCM974gNZqwpbD9tRVNIA5fCDbPYt9aT
    YsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664325;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bcxmPetaNeoyqH5ZbfAVBHQRy1lKfYG4Y9e5+9dijRQ=;
    b=iaDXT0+as8ICGDBgw79QhSX6XNS4BZR3UsAusvMK9w+jhVaLCRhlsgXVJH4Z1ON3cx
    Kx1ho205Ye0P8+IsV4BKLy/fjk62w3n9i4dPuhsRxoxi125zffDbxofT46lR22JKVhRL
    IH0wZsVYon1KkwpsnvGscv1ykYgqy47XOdmWI6aj7EtMy1vf1MmoCcJo7bDYVyK/cAZb
    Sl1J6cezbm7Jsnmc7B5VLG1F/gvdFuXyFgLZunq/UuatH3ZOcIqMsfDTy8u15NDqBqwY
    iXlRhtsZgUI3Az/pE4sbr66SCh/7H+3IIO3EaLy431cF0AS7kmsUu7SU9R0bkpVlYl5A
    QDXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664325;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bcxmPetaNeoyqH5ZbfAVBHQRy1lKfYG4Y9e5+9dijRQ=;
    b=Wo8fVrHDcv7ac4jvt6GpD0Dow+w6+CTjsVBNBsOp/AtXQOsUiwwb44l7TJBIvvj7Cm
    UhWbDctRhdpDq4jESzwcvL60Uzpj4KYM8COqYt1TvOKeIA4Myv6bEBtBO+DH6td+DBEF
    h43Fy48OXbW4u2Jkw7d33MYTVQIcwRoH2rWAlM8ZhY3hk4pabEAV4ubwD7/3rUjv6EsN
    5P6uDPiq38gJ/Jpf/e/LES3TMzWas49jAUJLHmPNc7u8ha9fs2PNg523fYHfpSjbIllq
    fxesOW9zTZG8wz1yh086Nwpy15JwahZLWGj43bQpS9jQB8Eu/QTiCzw0k2pH3o3hvJKQ
    YGrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664325;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bcxmPetaNeoyqH5ZbfAVBHQRy1lKfYG4Y9e5+9dijRQ=;
    b=QmzB8btChuzzFszrLAY8deNCFutYzgBsfv0aJ3ukR/MdI9CmW4otr54dFpZ9c93paW
    XOElpQ5lqVw21g6WEfAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjP9Db
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:25 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v3 17/17] can: dev: print bitrate error with two decimal digits
Date: Thu, 20 Nov 2025 19:45:01 +0100
Message-ID: <20251120184501.27597-18-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120184501.27597-1-socketcan@hartkopp.net>
References: <20251120184501.27597-1-socketcan@hartkopp.net>
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
index dad49454df73..2abf2233539d 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -151,23 +151,26 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
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
+				   bitrate_error / 100,
+				   ((bitrate_error / 100) || (bitrate_error % 100))?
+				   (bitrate_error % 100):1);
 	}
 
 	/* real sample point */
 	bt->sample_point = can_update_sample_point(btc, sample_point, best_tseg,
 						   &tseg1, &tseg2, NULL);
-- 
2.47.3


