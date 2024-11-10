Return-Path: <linux-can+bounces-1936-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F819C33B8
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBB0B20ADC
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22355896;
	Sun, 10 Nov 2024 16:04:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741494C3D0
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254665; cv=none; b=GoE9OMuluyPL9k5xRELAlzcjuwv+AJHuzxxcmvWdOO9ltuUx47dTiT2RrlHz9CbRC95A7BqV4TNvF9dhXqr8rogVy7NQxYhEISXSxWVxeUzImj5PnG5owdS5fmWH1LWDLIE/I1JZOeJxSoRLxmgd0HqxM28iuU0CsYjkIHUyCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254665; c=relaxed/simple;
	bh=eT4rowDerZkBSfMee8VQToOfpqp9JdOc8n5vGLHUH9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eW9jkNg41qbk9slzo03xgFMOUhrgvsxPUC0C2lbw8nakVEpjWPjzp1qN6rWuUC/ufWcDEq/H4SCHiC4we/JEJhuB4YrTCo8PDGDBn1VGaxgQnDWJMH0/cXNVw+groYz0CvnvKJOIw9xWG++fJTy10SOwz5IV5WXvYzvQnL3QmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso3418407b3a.3
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254663; x=1731859463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBIQfFhU3xQG5Wk9/dLx+cOFxawvD8ThhvTVQImaUkM=;
        b=O8JxbLapz9PNicUTwfMZujNrZ8LUD26ejFG3x61tQWvaVrjCPpIkXsI6xxxpj4Goru
         s0FtS+mJMjWeITKZ6hbX2sSUaxQDPMBYegFiIJ9/NsN/vLgQqVLDcgytkJwMF6f5vPnP
         iBmukWJXxv+b0ieDU0Q4haUCYa0tuWTPUD+WvwYRue1y6xiohEkkUTCXpQZiCcGr/TcY
         FqV8yYtQzCrtCK4UkOUbHu/Y65lGTYnFTwUFQ2mAdUFMTrRtOqNQpvoo0RErj2mC/B1F
         vdZiGpVllNTLmdZX4j9jzP4MDUxgoUj0pOaqCxBRtY6eivGm9K9CU87TmM6TJmGDtWIm
         WKOw==
X-Gm-Message-State: AOJu0Yyl1NISjwSRIoh0H3sgCBU06odlTnkSvGaAi/kT2F1StLnhXCj0
	brTECVBrHQpTph7pdyVqGSovtFwCfeaeVVKQKXOmw9EBGKNxbobvmcosMg==
X-Google-Smtp-Source: AGHT+IFQ0dyoxb8mLA7b+vw+Ae6YIgCwwCN3KlE4mdcsAfppbMq55PcIPeESUc2nay3qdwhVt3RrVg==
X-Received: by 2002:a05:6a20:918a:b0:1d6:fb3e:78cf with SMTP id adf61e73a8af0-1dc22b91c6amr14671107637.41.1731254663465;
        Sun, 10 Nov 2024 08:04:23 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:23 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 0/8] iplink_can: add CAN XL
Date: Mon, 11 Nov 2024 01:01:30 +0900
Message-ID: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=eT4rowDerZkBSfMee8VQToOfpqp9JdOc8n5vGLHUH9o=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN8vOPT/i9LDzzBfuUzGzm1c239/w4ILkUYblTYXzY iyedfks6ShlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRQieGfxbXtz6OWpsTUnLr 9R//F8efzt/xW+TxBHZ7KdYXM43ij7xj+F903pHpYd0zv6hpuU+1jnlfPl4msKb5yKr6t0HPHRV rH/IBAA==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

This series is the userland counterpart of [1]. It adds the XL netlink
support to the iproute2 project (a.k.a. the ip tool).

Read that other series first before looking at this one.

[1] https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/T/#ma8740c1a71b37b32188b6c7b8684cc7b765a3e6d

Vincent Mailhol (8):
  iplink_can: remove unused FILE *f parameter in three functions
  !!! DO NOT MERGE !!! can: netlink: update headers
  iplink_can: reduce the visibility of tdc in can_parse_opt()
  iplink_can: remove newline at the end of invarg()'s messages
  iplink_can: use invarg() instead of fprintf()
  iplink_can: add struct can_tdc
  iplink_can: rename dbt into fd_dbt in can_parse_opt()
  iplink_can: add CAN XL

 include/uapi/linux/can/netlink.h |  21 ++-
 ip/iplink_can.c                  | 306 +++++++++++++++++++++++++------
 2 files changed, 261 insertions(+), 66 deletions(-)

-- 
2.45.2


