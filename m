Return-Path: <linux-can+bounces-2001-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD7D9C5FE7
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1ECB44570
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3009A212F00;
	Tue, 12 Nov 2024 17:28:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D22123F5;
	Tue, 12 Nov 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432503; cv=none; b=biH9dUbaxmZBTiyaIZriKJVDZMr1D81dtct303cuEETzBUrwqa0ltRlQIqRe75WgYbAiJIMMACho+9Imbh2FkZ/pcv+eTEBrDM2eP47KQ5HfP0tO48bXX7O3RQgtiQVzhKFO8rSrlEATq2nvZVp+tiw4Q8zQXvGu1mWxtREw1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432503; c=relaxed/simple;
	bh=kEmLs7AIl4KJJoNpvkYxbCc+VQHOTRK6HDlX8ATSTRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKAwfHSCeQGWhAKQvrrePqVqHhO8wXFq2YfjmCLzWy9OFhFfoEyojHrRCSci0vT4s0bMdO4NJaMyn7lHKQwrFRXurQx6C36/X5X2sgwqVKN4UhO1lgA49Rl2s+T7M3zOkDk43e2tQWs0uoQd9dkfGpNE5jAJ6vN40MugK5udZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7240d93fffdso5044517b3a.2;
        Tue, 12 Nov 2024 09:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432500; x=1732037300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xg9pGeBfbXErAt5ozvpbmhu71gFQk0MAcz2grEfEcLE=;
        b=lWmFL5umhkvQKwjg6haVPhPFQ9GYPy/CZte9B5YbDUUQ+OfAF3pD63ENxrwVSDm6Rc
         f9lEZTdwpjQpdx5NKlR5GO0FfnnaLD94IHz8FTA4oGK50FiYMRCmPQwe++Tbco5Hdzh2
         ADSQpukt7kk4DEgX/OOCJbcIwZ2ShyOFF85x+1DV8aCV6qoIFdAGb/BNQ7h+gcGv5jl9
         QEkmUULPgQMXhbRcz7fsBIQAKS9DoaM7vDCeBWLx7eJHUGGaUdjYckV8CV1NY4XLKW/B
         41KQDbhlXoIudHf2DkoD548I3Nm7qavO3OCi2L2AE96dRsqSl0IQEUJMxltdJw2JVs8d
         lx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKYrq9RW2BbwJGz4JroaQPgK9GJ81hOmhViO6VSNmITP1rezHstl5N/UhyHu5SKzeJKuNupnd81wk=@vger.kernel.org, AJvYcCVdA4eX5b4OoIUC7T0R/MoSvHdit3io51mWrVx0Vc0m3YgspGhWdohIxC2snq770KhIRGxmKJQBUQA9V7+b@vger.kernel.org
X-Gm-Message-State: AOJu0YzXys9b7p34FHH27tTanvdOeYodfXzIzMzECW9p2S4Ywv+M+S8g
	gXQhRHfBnX63lJB/N/OtpIg/CPajqZ1YZ/u97DcE3j52L83yqTLiWgYy/lJc
X-Google-Smtp-Source: AGHT+IFSunQvXfmcX8mlC7Ch0sFxtf0+GmtXz1ws6fo3/szgAe5Cr5U9YY5KZIzLSUIgq2jfj5+hkQ==
X-Received: by 2002:a05:6a00:2e9c:b0:71e:8049:4730 with SMTP id d2e1a72fcca58-72413261790mr21385325b3a.3.1731432499524;
        Tue, 12 Nov 2024 09:28:19 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864f78sm11481439b3a.33.2024.11.12.09.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:28:19 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH iproute2-next v1 0/6] iplink_can: preparation before introduction of CAN XL
Date: Wed, 13 Nov 2024 02:27:50 +0900
Message-ID: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=kEmLs7AIl4KJJoNpvkYxbCc+VQHOTRK6HDlX8ATSTRI=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGE3SSn24SnyKnHjixe/sC/n0td2INNlQ5dV1QfzSvN a/aKbC3o5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwERSTjP8r/3fbZK6c8eqGt6L 73dOi/JcolVwR/VS02uXlxIlF7Zm/2Rk6FTb0fqWe+pe3+sm0plPvy6IT0+7yWublbaUU/3Cpem n2QA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

An RFC was sent last weekend to kick-off the discussion of the
introduction of CAN XL: [1] for the kernel side and [2] for the
iproute2 interface. While the series received some positive feedback,
it is far from completion. Some work is still needed to:

  - adjust the nesting of the IFLA_CAN_XL_DATA_BITTIMING_CONST in the
    netlink interface

  - add the CAN XL PWM configuration

and this TODO list may grow if more feedback is received.

Regardless of this, the RFC started with a set of trivial patches to
do some clean-up and some renaming in preparation of the introduction
of CAN XL.

This series just contains those preparation patches which were cherry
picked from the RFC.

The goal is to have those merged first to remove some overhead from
the netlink CAN XL main series before tacking care of the other
comments.

[1] [RFC] can: netlink: add CAN XL
Link: https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/

[2] [RFC] iplink_can: add CAN XL
Link: https://lore.kernel.org/linux-can/20241110160406.73584-10-mailhol.vincent@wanadoo.fr/

Vincent Mailhol (6):
  iplink_can: remove unused FILE *f parameter in three functions
  iplink_can: reduce the visibility of tdc in can_parse_opt()
  iplink_can: remove newline at the end of invarg()'s messages
  iplink_can: use invarg() instead of fprintf()
  iplink_can: add struct can_tdc
  iplink_can: rename dbt into fd_dbt in can_parse_opt()

 ip/iplink_can.c | 107 +++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 51 deletions(-)

-- 
2.45.2


