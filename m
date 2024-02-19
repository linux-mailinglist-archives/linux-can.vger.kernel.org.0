Return-Path: <linux-can+bounces-305-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34B85ACD2
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 21:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD4D1F23813
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 20:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938BC374DD;
	Mon, 19 Feb 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fuXY+f/a";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZZxDVdo4"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5B44C93;
	Mon, 19 Feb 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373572; cv=pass; b=bj8cQGydWxJCvIlLmjrkMIbl/jAOdO6/q7hv5h/J6YvzvhE1iLgX2NkqOtK06JnV4NEt4cPpq/BoFzQrZS4CUUXnNx7SUsed5Oyp28Ud6GPZhiaSNMjos2wZcVcUtv8NeJA1DHW0E/1/BA2+1Gey1gPipnvluhmNtkbASXRC1gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373572; c=relaxed/simple;
	bh=jlr4MUPaJHtY7WN6wZtuymdp2AJaAnZftYzFQjTdACY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K/9NAM3dORIP2mU8MkdH1BZNY8/X9GRgT6GgN5MIjTp/LdVNFyOwZDdnIENsrZgh34lD6wyF4rx/VRoy4zLueyT0VzvIBmiepdVnd1PCshdLgzWgmU5oq+oYAXJsL/K9ag9+UhF7NGIb3wjcLa7nGfn22zLtD/yR3eRJPvoHjRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fuXY+f/a; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZZxDVdo4; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708372838; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mN6QJ+sxIMXoSG6epccqijmnI36/lp5q6Cln6vSUe2Ad4BbiDhc9YrQJnps0RirbGg
    /zDk2cayNN39jVedfwc8mQDbROHwflKwQ/j2gjyvrnMxWtfGCtq5YDKtiTNIba5jyTkW
    EBzgpKKafLDxC/NrlwAreBIbMW16lS6v7f80Jpe8lTysMskdJLPudW36ry1IdEwCTibl
    eUhcf0Ftd0T7levGhDwz8aqzVdRWWJi4N+8w3KPKTpZoZ/j2yWmgy29qgPfY96Bzx+jR
    uhJEWIh6AjaMWFTNJhK15iDdm0JGuZuCx2oeMzuuHZdnnpWpei41lGAULz29mDj+RS4W
    25uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708372838;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gerfDKonhiUh+1/6+Ha/RGvFHombzVsvKHO0uNPF0kQ=;
    b=ht9V7uqTuWifk7Lk/K4qyL3f4RTlH0aoyGoppwKq8XjE6gUaOhfei6b7wgScVq2I+8
    7AjDKr08dx9mbafu/MH4AsFma/ckC731SiWTFsXg5Vl3OtMIyth9eY0IAno3eT3Slmpl
    6bRE0pHKVAmI8ElPKcE6EO3nQO1W/Ll8sjZ1VKa7XPhgFAPydXUfxpC7I5XU41lvpA1i
    Sck+OM8u4Kl+q/NclxiodeMuYoIYFGPPtguAGXFPlLB12eT/v5jplsubDrDOv0I2f8Vi
    HKFmJJHJBXsaETmNvFT2gczBvOTdqd7+3EG6XT9y3qt72D4qAHeiwrjghlHd9QztD0i7
    /Qjw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708372838;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gerfDKonhiUh+1/6+Ha/RGvFHombzVsvKHO0uNPF0kQ=;
    b=fuXY+f/ad4I6PByV/vo/mwqZPkJUeMlrFnBiLdnTYLrJCWl5LzCL7eU0BEEyNpjzUt
    EG0dQUMdg20b8rY53XYF/c96IH5dx67qmQAXDpAtzEOzfKFpUjVMH7hhIpecQV57WQbU
    hZM8bMQxjhm4R+KYP2bv7pX5csoJoVQx1bczhmhUggzd7As27npOVoQ9F0txEXFvzyxz
    WOpWOT4iTJlCgCjgcBvT8P1G8divlDEXhI26uq7Iju6oLFPqj7Fbyi/GH1u+PshBsS0y
    vM8nYl14B4mreEFDpcyOsBhpCg3A++4WH+kx7j1WrtSxGHRpJzyd0e19qrES/4K5276b
    hzPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708372838;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gerfDKonhiUh+1/6+Ha/RGvFHombzVsvKHO0uNPF0kQ=;
    b=ZZxDVdo4m/8kQwSsgIH+pE/IhonsQRBv149dc05TsEAC38WSU2WesGzWsdQomCS8KK
    /li+fD1Gjw/LHNBhwZBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01JK0c84b
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Feb 2024 21:00:38 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	netdev@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH] can: raw: fix getsockopt() for new CAN_RAW_XL_VCID_OPTS
Date: Mon, 19 Feb 2024 21:00:21 +0100
Message-ID: <20240219200021.12113-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The code for the CAN_RAW_XL_VCID_OPTS getsockopt() was incompletely adopted
from the CAN_RAW_FILTER getsockopt().

Add the missing put_user() and return statements.

Flagged by Smatch.
Fixes: c83c22ec1493 ("can: canxl: add virtual CAN network identifier support")
Reported-by: Simon Horman <horms@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index cb8e6f788af8..897ffc17d850 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -833,11 +833,13 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 			if (len > sizeof(ro->raw_vcid_opts))
 				len = sizeof(ro->raw_vcid_opts);
 			if (copy_to_user(optval, &ro->raw_vcid_opts, len))
 				err = -EFAULT;
 		}
-		break;
+		if (!err)
+			err = put_user(len, optlen);
+		return err;
 
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
 			len = sizeof(int);
 		val = &ro->join_filters;
-- 
2.43.0


