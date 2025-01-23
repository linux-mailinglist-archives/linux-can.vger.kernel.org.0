Return-Path: <linux-can+bounces-2678-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91FA19FE0
	for <lists+linux-can@lfdr.de>; Thu, 23 Jan 2025 09:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B5E18843D4
	for <lists+linux-can@lfdr.de>; Thu, 23 Jan 2025 08:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60B20C02A;
	Thu, 23 Jan 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSayIkE+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC3320B;
	Thu, 23 Jan 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620730; cv=none; b=o4WCHC2U68oFIuBpPIz6mNxFIyPf4SXlFxo62XQ1a4nrYglfL9Zpz+Qiv70VAUoxVcDX0aDGbxkcHKnttlhLLVSa3vV2LJZUkuXCAz1hv1py80hupFktCkvbPH+SL+rUJD3nLjPJ6mdHzw8Q88r7GuKP7iyUZ/HeoHXrvX2ODxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620730; c=relaxed/simple;
	bh=0RqbJsmBYD4psvJjsPR1/k8+RZSZVR7ryEwaJzId76g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kyh2c7hV2ImG1G6/Nz8a8LZlYSLWnlGJU+AeYM1zGY5d/Lue3KXrGh/hXFslLAy13QQzthkoxZKsi/gJ1RqotRBxM2NULJPDZyib++1lWs039yM23K0DUn9ItgV1QqBtf+GCeR9n3ADVUQXV8NaYVC5aC4cGC3c2rux1e3VWmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSayIkE+; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so3707585e9.1;
        Thu, 23 Jan 2025 00:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737620727; x=1738225527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7x78WrC+cTNtBpfnkOUA5kq6ry12btJ1fKxNdWFZpHE=;
        b=TSayIkE+0U+pOvEuJnRxcZgVtCapfSagrwq/toiKmQ8w4Wb4hJCpPg6r0QO8VTxCpi
         O5iirqYdfrYwF9HYoyZ3B1qoirJZcahDRj4VoIbT2s6qS6dETU/FOVdCTgaMxXCMVgU3
         kawda30JBuXD/72WCKpQTS/3EEWJk47Jl3FhpbyrWtImmjS6+DDN1u1e0l/IjJLj1R9o
         O3EUq3Rk3mPZAYVtLPJPNykU5koESxoUd0rtIW4qiv+8VfM/fCYEBTy4Qk6UYLDtzk1W
         oLV6EDoHkmSKiktgJ+9LMmSPec9Ocj7ZyF/O8Pr1qjHOONap3CbJhKCkKGbWczR3nT2C
         2d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737620727; x=1738225527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7x78WrC+cTNtBpfnkOUA5kq6ry12btJ1fKxNdWFZpHE=;
        b=mxmo3pGNz6zxiC9pokMJ2tYJt0MomVCfOiYxUvJM24fAvr7EcWzbO5dcn2zGPpWont
         67ccdR57rSp50TizY18+gdYKy6f/FIdGx/R5vm/hZncWL6NJj7cU+WzljqbKpc7P+w8S
         gRxB63T/yod/bLcGNpo+XOUpWYizO09tWHJv4bBklEGPSC3QqzEiBp9OLYwb19WbqMCz
         dITgnso3Nql5nHV1qMKqwvBUFhLRTpItMNbYNlNvO0EvlllIpL+TITwJt42bR9rGti5m
         Bs7gedb8lwKr12HVIYReezZ6PsA7rYLS651zIvrHNhL618KzWw+AfCvUoZgQ04a4aFsX
         HhJw==
X-Forwarded-Encrypted: i=1; AJvYcCUbuOP5EvEk5GKTki3+/OehmCHq17Wqu1OAiQQZrb3PJLaIGzDS81+vPXQyLbBjzSzq1HcnvXp6@vger.kernel.org, AJvYcCVDW/khwxbsYEhBa1w9XGZL68gQtGvSV/gFyUwJdEZzM62sfLVoas3mF4bayYAY6fDf+L+QK5I1eGa60Js+@vger.kernel.org, AJvYcCVrjRI0wRHLSoVb1ZDyLwl+TwWKU3dlb0ERQKOYJ8xfpGPs+VbZa66y8+RXbhLZmyDh3BbVz5N1FgIO@vger.kernel.org, AJvYcCXNNMSU5KlhDD4rJAWdGpvu/yDfW1AxfOynrqLQ9jX2TnxzV37c8yJ3xzlptrfp9UCkq4mbGivcEwQ=@vger.kernel.org, AJvYcCXzDM37I4hjPWQ9EUCI3nS5mv9P/zzW09OOAMogCk3bjIogdCQgBlKf1kmGayYEF+RoUYEd+YfgKhD39dpjbIfqzzTOIy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl19QpVZVAoF3ZhSSwTw9u28bdknKZC4IIIHH7gkzxMAXRWsC9
	vbCow9pcw4yeMB+i94ibcQKrNLsBjeSdWFy5Pbemyw4KAIhLlELe
X-Gm-Gg: ASbGncuooC5rub8bL3fLdEg3+L4NnNFKWsODHwXDNsbGmC/VqWB5/dViDG9OMEsLkrQ
	LD17jshJYW5hEnPYfiYTldAMmTsYMLti4NZswHGje3w2Scpr0rpSyJnMEP9DGYy9X2ozeFIYPOc
	3xqPu/Ec8yPGqqf1QNA+j4stAqNCFq/Hq6pt44M1TnPiEsAnCkhR+mLjtdJwcpZYsxzxYbz9c/K
	pqa5xGHlrhBdBvETlG1cn5cl9iS6jEn49i8LxKZvBCj/+2xtnLynGB7esnAIFxFVbJ+aiBBG0X4
	NzPgxPbCZoYfh0YQ5EeVBdKvJqch7bg=
X-Google-Smtp-Source: AGHT+IGC68+iWj/tGHITjYEzoOGz/ssjpVakkTiozXCptHX+mLeBDtIXnpipmOJtFYfncB14B/hKTA==
X-Received: by 2002:a05:600c:3b94:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-438913cb620mr264534565e9.11.1737620726503;
        Thu, 23 Jan 2025 00:25:26 -0800 (PST)
Received: from localhost.localdomain ([197.63.236.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3215bf2sm18829969f8f.18.2025.01.23.00.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:25:25 -0800 (PST)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	shuah@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@vger.kernel.org
Subject: [PATCH] documentation: networking: fix spelling mistakes
Date: Thu, 23 Jan 2025 10:25:20 +0200
Message-ID: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a couple of typos/spelling mistakes in the documentation.

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
Hello, I hope the patch is self-explanatory. Please let me know if you
have any comments.

Aside: CCing Shuah and linux-kernel-mentees as I am working on the mentorship
application tasks.

Thanks
Khaled
---
 Documentation/networking/can.rst  | 4 ++--
 Documentation/networking/napi.rst | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 62519d38c58b..b018ce346392 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -699,10 +699,10 @@ RAW socket option CAN_RAW_JOIN_FILTERS

 The CAN_RAW socket can set multiple CAN identifier specific filters that
 lead to multiple filters in the af_can.c filter processing. These filters
-are indenpendent from each other which leads to logical OR'ed filters when
+are independent from each other which leads to logical OR'ed filters when
 applied (see :ref:`socketcan-rawfilter`).

-This socket option joines the given CAN filters in the way that only CAN
+This socket option joins the given CAN filters in the way that only CAN
 frames are passed to user space that matched *all* given CAN filters. The
 semantic for the applied filters is therefore changed to a logical AND.

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 6083210ab2a4..f970a2be271a 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -362,7 +362,7 @@ It is expected that ``irq-suspend-timeout`` will be set to a value much larger
 than ``gro_flush_timeout`` as ``irq-suspend-timeout`` should suspend IRQs for
 the duration of one userland processing cycle.

-While it is not stricly necessary to use ``napi_defer_hard_irqs`` and
+While it is not strictly necessary to use ``napi_defer_hard_irqs`` and
 ``gro_flush_timeout`` to use IRQ suspension, their use is strongly
 recommended.

--
2.45.2


