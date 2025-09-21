Return-Path: <linux-can+bounces-4771-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669D6B8D690
	for <lists+linux-can@lfdr.de>; Sun, 21 Sep 2025 09:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271B244130D
	for <lists+linux-can@lfdr.de>; Sun, 21 Sep 2025 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A02376FD;
	Sun, 21 Sep 2025 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMZ/8AB1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84801BF58;
	Sun, 21 Sep 2025 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758439989; cv=none; b=WLXYVIVjVPh5QSke1FDqae+Pa6yJ53nqvELSlVNDBicJtyASEI9YWAqkqv/y6eMbEvJ2my6GEMDUF3RJOdpDjZqJHG0MSj+VLjpKItl2YKGZtCbDhF3yyXXHb7aOUoTXTstcB95STwVDZ0hJ6+5z89tCu/mjOiv9r56P4PwRmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758439989; c=relaxed/simple;
	bh=rgvlCGWJgxQtna0rGORmWRGCmS8XGEFNOobwOFZsJ34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ptaZgGmPzksh0CsFUqmupa4kv8p6VzVpL02nOYVVKhwq/97bKC/Om+BvvleqcDc8Ev/yTnC5Fh8PM48TmC617/ROHCl89i57+VJclYWijdQgIRvBEuDVcDxbkujsYMpxgwCkSbrONMBD91i55CCDEbG/b87U/GGAR1rGdGaHyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMZ/8AB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A21C4CEE7;
	Sun, 21 Sep 2025 07:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758439988;
	bh=rgvlCGWJgxQtna0rGORmWRGCmS8XGEFNOobwOFZsJ34=;
	h=From:Subject:Date:To:Cc:From;
	b=cMZ/8AB1m56IINYIibfXHxrHAOuMfZbBoHgIeRfMicqWbB5nH8f3moTsYjiSCBy4E
	 Zz+cONf8qHUrLzi8J0Us872HGcs6dIcLHl+6qLj/y4ZSDWGpN5lC2ktskevo3XsUX4
	 oJDATeadxeY/vy/98uxyqt1HdfPk39gw/zsHC3TYM8GMVqaI5609QTgBgbvvcyj42w
	 javl94BEU7JHG/5IDTfvDgy/mE/h9Nd8Z5xqZ7bkvbxtA1nt2KJEOta7f/IOW5xkaB
	 4lJeNfWIDAEFO0vghpeEXNzpkxqF87mmtd/yI1QNKmR8nzFVFo8heczQdaUOTL8Sm5
	 wQuVPt9pfEeWg==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH iproute2-next 0/3] iplink_can: fix checkpatch.pl warnings
Date: Sun, 21 Sep 2025 16:32:29 +0900
Message-Id: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2qz2gC/y2NUQqDMBAFryL73aUaLLRepUhZ11UXa5ImsQji3
 Rvafg7zmLdDlKASoSl2CPLWqM5mqE4F8ER2FNQ+M5jSXMqbqVD9U+38YLLIk/DsKfGEg24SsWK
 6lnXX1wPVkAs+yFfkwB3UB7cmMWhlS9D+dJDXmj/Tf9NRFGS3LJqawgUd1Z4XUgvtcXwAQ0+WB
 asAAAA=
X-Change-ID: 20250921-iplink_can-checkpatch-fixes-1ca804bd4fa4
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, 
 linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=rgvlCGWJgxQtna0rGORmWRGCmS8XGEFNOobwOFZsJ34=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnnV2mKHfD4tVru1eQKxyfhE9oXi6xbozrvqJPvMqX5r
 ztKN37Z1lHKwiDGxSArpsiyrJyTW6Gj0Dvs0F9LmDmsTCBDGLg4BWAiun8Z/vvde/JdP3hZws5H
 M5WNrrAd+RXy5PeD6XOFZs9/8+LYVn8hhv+JZm+idzGbx77ljBLfUvnoU8UC5pVVEnuf8l5d9jl
 y7WZOAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This is a clean up series which goes through all the checkpatch
warnings on ip/iplink_can.c and fixes them one by one. By the end on
this series, there is only one warning left:

  WARNING: Prefer __printf(2, 0) over __attribute__((format(printf, 2, 0)))
  #320: FILE: ip/iplink_can.c:320:
  +static void __attribute__((format(printf, 2, 0)))

Because iproute2 does not declare the __printf() macro, that last one
can not be fixed.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

---
Vincent Mailhol (3):
      iplink_can: fix coding style for pointer format
      iplink_can: fix SPDX-License-Identifier tag format
      iplink_can: factorise the calls to usage()

 ip/iplink_can.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)
---
base-commit: afceddf61037440628a5612f15a6eaefd28d9fd3
change-id: 20250921-iplink_can-checkpatch-fixes-1ca804bd4fa4

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


