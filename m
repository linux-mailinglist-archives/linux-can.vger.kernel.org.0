Return-Path: <linux-can+bounces-4693-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E760BB574D5
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 11:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25EE3AEBF3
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51A2F39CC;
	Mon, 15 Sep 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJRYu0Cx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8A27FD6E;
	Mon, 15 Sep 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928251; cv=none; b=swb7pjSlkI+kQ3HOCyuKnMDIpfMSen23O6LwmUtM0m0xS8hRBiQikMbRnS/71cQ2mbj4Q9FTwBpC8j+HqAwugos8qd5OyyFPkIaaVAAGA/Agcf6edLL+2kdsaFeZl0Akkrr30GIU2Em46iuMmEqtIP7xu4ALWdGHlwMbHjytnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928251; c=relaxed/simple;
	bh=JBZlOusTcmbmYsPbKb8J6BxrqcKJL3ZngDZSFwZQWY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y4wcvXI/H/uPbV1fuXq+6IMruhFYRWg6vr2gqyQ7ui7DXeWzh3Zgz4QjK+R031G8SiJ8H/eh7OEbe+JbqZD4pzuyK33gT9XROvOualEQ5G1VtXQPctqg3xoUfgGwBj/qUT+2lZJZx9QBhYu54MOzFlOrSA5OVwFXKQRf+ohnJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJRYu0Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A8BC4CEF1;
	Mon, 15 Sep 2025 09:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928251;
	bh=JBZlOusTcmbmYsPbKb8J6BxrqcKJL3ZngDZSFwZQWY8=;
	h=From:Subject:Date:To:Cc:From;
	b=OJRYu0CxmC9Iintt9hOGT1Y8L1JcW0zPHBOTFvWfD5waINWAtHHwP9A8+S5krroJJ
	 L1HX6SYwelOQrlbAoT39wlr/r7VSVo4kTiP7qD7jM9M7kdYPqtTGbYH4JyyQ1bCE3k
	 RjA/tehaPlI02k89+0Av6YKy9OpgXHmlOETwrVN68lffxc7NL9qpDvvPkJQQJR5VAy
	 ABszhjIcVxvCYX+gripwFvlqxv/dgm0dsARLMtmAfVqjqwXJxgT8wJuJQIsR2KNvwb
	 hFin669jOxPgEphsfuKI0A4GvjguSwK5hP2nwuk3JrWj7dC78fEWv4cEdrjATvdjqX
	 43ndtow985YTw==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 0/3] can: raw: optimize the sizes of struct uniqframe and
 struct raw_sock
Date: Mon, 15 Sep 2025 18:23:12 +0900
Message-Id: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADbx2gC/yXMQQrCMBCF4auEWTvYBLKwV5EupuOog2Rak1QLp
 Xc32OX34P0bFMkqBXq3QZaPFp2swZ8c8JPsIai3ZghdiN3FR2QyzPTFLDPxCzl4ojFEZu+hneY
 sd13/wetwOMt7ad16jDBSEeQpJa29M6lostZzIjUY9v0HTOPvcZEAAAA=
X-Change-ID: 20250915-can-raw-repack-c21aab25cc11
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=JBZlOusTcmbmYsPbKb8J6BxrqcKJL3ZngDZSFwZQWY8=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnHb8tN5ugID9rzKyd99cTmVxc6n/4ub2/5uf2hd7yj4
 BaTa10lHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYyPZjhr5TIheKiffIPRPe9
 WrCgurDG1je05njWmj19V+zyt8zL6GBk2P7UnnHjjI59bKcl3E/8j3RKKllm4JwZwy09e3JHRbo
 DNwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

A few bytes can be shaved out of can raw's struct uniqframe and struct
raw_sock.

Patch #1 reorders struct uniqframe fields to save 8 bytes.

Patch #2 and #3 modify struct raw_sock to use bitfields and to reorder
its fields to save 16 bytes in total.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Vincent Mailhol (3):
      can: raw: reorder struct uniqframe's members to optimise packing
      can: raw: use bitfields to store flags in struct raw_sock
      can: raw: reorder struct raw_sock's members to optimise packing

 net/can/raw.c | 51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)
---
base-commit: 5b5ba63a54cc7cb050fa734dbf495ffd63f9cbf7
change-id: 20250915-can-raw-repack-c21aab25cc11

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


