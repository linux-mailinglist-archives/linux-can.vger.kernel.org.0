Return-Path: <linux-can+bounces-1297-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4296809F
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EEC1C21757
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFECEEAD0;
	Mon,  2 Sep 2024 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyIJvoci"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E43C00
	for <linux-can@vger.kernel.org>; Mon,  2 Sep 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262319; cv=none; b=k7Uvd/vjXn6FwHALRInxSqVl7TuWTUCfDg8BR6aqGS6ubaKT3kqL1+deUxu9y1WH66TPNC9zWwtzKkZMGjvWfZXHqy1okFKtrzc9jLKt9sod7bpmtPfJn9Hm+yUIDeOWwEKb11I0WKjqYFfhB7JCUBye2a/nkAjIYV1WbJscO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262319; c=relaxed/simple;
	bh=VYWxwAvhkLuKPpE2aKjnqJ2tnF3raRJ7v8jbIXvonwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fs24vg+JHli1QxrQWJLHVKOhQSvtWepAbS1oS9BStiJqPzsPXAhHlgnbphzZoSbDSPJi8Bjh8JlHmf5Wz8XE6RJlT0N2/CJ00hq2ZvvLB92rbux3UKUQOB9CibvdsPxcDVPd/NW8nWy5ahFrPwq+8FV6APfijwpGPtxaJ8p6Eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyIJvoci; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f4f2868710so40993781fa.1
        for <linux-can@vger.kernel.org>; Mon, 02 Sep 2024 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725262315; x=1725867115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYWxwAvhkLuKPpE2aKjnqJ2tnF3raRJ7v8jbIXvonwc=;
        b=SyIJvocixO9Hr5UMpC2a4Q6TxPdNBH5pgd5/CHL4s6dv8yA2kIvN8+Lk6cS7B7/3+I
         naUMgy2J4/uOAzFPgOmc1h3sZQdwvx3+fYslulUIqEqm/6CZRuIf7Gk3rWBjguNSfg1g
         nizjXxap5xQZpAnaEivppmDbFCUMSGnIXSsRNGeSgcAj5ikdgLb4pu/fn1ks8JV0Nkyz
         BoQWkQH0djjA4fsfZkh/D9OccWxu9MKGwlUE9ESop6PaD+tsTsOm6UCSLqfgd3nhRFSN
         aIWyPj+W7Jxyjh0KLRWIpQAEBrBck1wt4HYukQIiyrLzPJp3UjMt7MQk7A25tUM8UKn5
         QV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262315; x=1725867115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYWxwAvhkLuKPpE2aKjnqJ2tnF3raRJ7v8jbIXvonwc=;
        b=LRy0I1xizHJLyQgaWTJ1NszW0RobeiSt1QJSAMb6qw/uNlw8v7l5qWAme+rO77O1Ip
         FxmJ79nsIY89DKNL5UOnmp4yJUUcg0h5b+P5AU54AwJOnMLdTkymjT8kd0WIRwTRrC8q
         BmaHR+Dq0SUPD0icVVB3HSuDuFc5SFCzA5XZGKt9WdYLBLZorXSabhnt7P8+5u36JZln
         GAmUzeFVNxgVOQXZ4DTMQK/v5MIpQvuw0+FwyOzDrA6H15Z2Re/tGYiYCJcz8xY/7vI3
         qL9CgOTicuhGAjz3NX1/x6vMkvN9U7LAz8CU9fRkv5mSJtjKerGHag2y8sYkF/0huojB
         Bi/A==
X-Forwarded-Encrypted: i=1; AJvYcCXH6AFsbNggGCl5bdO1i2jRqiyGZryptPoPsIMEyjCptZIzrYKgPDxrVfPb6kf6yLgxoHNSYzWUvA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcYwl99NS8Xmn4vvcHGXep8nLsIct60VWxYnlqWkllOnqisou
	/4a26jL0Bffd66P9j8lW2d8VOh4yNqcFeeOpZZIYziICqZlm5NY1
X-Google-Smtp-Source: AGHT+IFLKS0s5tWhZgm741hN+pzHdXBktAkClb8elyk1pVRpR5P/QnqJ36pX/VvIlCY9gtwU7+0+qQ==
X-Received: by 2002:a05:651c:198d:b0:2f1:929b:aef6 with SMTP id 38308e7fff4ca-2f610923301mr105230021fa.36.1725262314775;
        Mon, 02 Sep 2024 00:31:54 -0700 (PDT)
Received: from U19.ag.local ([83.69.218.234])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed1787sm16894491fa.10.2024.09.02.00.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:31:54 -0700 (PDT)
From: Alibek Omarov <a1ba.omarov@gmail.com>
To: mkl@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: Alibek Omarov <a1ba.omarov@gmail.com>
Subject: Re: [can-next,v3,00/20] can: rockchip_canfd: add support for CAN-FD IP core found on Rockchip RK3568
Date: Mon,  2 Sep 2024 10:31:17 +0300
Message-Id: <20240902073116.1620038-1-a1ba.omarov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resent to include linux-can@vger.kernel.org by Marc's request.

>This series adds support for the CAN-FD IP core found on the Rockchip
>RK3568.

>The IP core is a bit complicated and has several documented errata.
>The driver is added in several stages, first the base driver including
>the RX-path. Then several workarounds for errata and the TX-path, and
>finally features like hardware time stamping, loop-back mode and
>bus error reporting.

We've tried this on v2 patch set, with a custom board with Radxa CM3I
connected and it's even more stable than BSP driver we backported ourselves.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>

Cheers,
Alibek.

