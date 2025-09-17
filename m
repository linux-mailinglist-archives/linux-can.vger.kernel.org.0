Return-Path: <linux-can+bounces-4718-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCFCB7F89E
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 15:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB9E526B05
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A6321D58B;
	Wed, 17 Sep 2025 04:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkup7laa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA019E992;
	Wed, 17 Sep 2025 04:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084535; cv=none; b=a69+JYyRSUWeqGQbv6Masf9olwvp5zR5tRXYL8LL1Qcq/dSbWl15vcMI81uncUkuZqHpc88aY4MG6HkCJ1kcAKrJCnoW1+kEmlJT0m8yJCvX48equ/T0fCNBGKv/vCq/3SkrQN2kcFX95xuETD2QLJ1ltyANnO0oIWhAhntQfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084535; c=relaxed/simple;
	bh=l2X5WYYtJ+/RmiIVJAaaTIO6p45pcgFI+gmCNpnaKUk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CVBnJWKff4Wke28Yh/lMxKFN/IN/xP0bG3SBTVBz7u1xF1w4Sx08Y8kcqSwmth7HbsEeAkz7QpQ8o7R2LVUHL205BSx45q02Hgvw7+5UBuL4sCu4Z+o+1KHB9RCq+MZs+g6EYsM/X+8Qw71ykNyl96wL8OCLbYy8PhtZ6zPGLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkup7laa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13249C4CEF0;
	Wed, 17 Sep 2025 04:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758084534;
	bh=l2X5WYYtJ+/RmiIVJAaaTIO6p45pcgFI+gmCNpnaKUk=;
	h=From:Subject:Date:To:Cc:From;
	b=Gkup7laaCJeyGMq79NOKD2/UBpjHBu1MPNcgVtnVamDIs8LifO8fKTzLlFd8bcccB
	 tx7Q/xAdqpu9lOamzJ9WZBCbpXHXMIbzoWbBK6RCzcinDQlvaVXvuU/Eph0y74TikZ
	 egdPp2vQMkM11OFijiHSfZRSp4h6V3jBYaScWLKU5frN1zbZwt9MGQrWq9ln5xm1uE
	 grDU9S1giKPAGCrm3ax6OH1pMtbtNS7x7QehrgAcc7FUcN3TNyTIfdWPsz/S9KyVYl
	 WJwvqmaxcYgHxjmdPgsz1kira5LLltNtpfYAKzHSH5I6a0qo/E82G9mtYSWxyTO730
	 TyRwXKKhwPo/g==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 0/3] can: raw: optimize the sizes of struct uniqframe
 and struct raw_sock
Date: Wed, 17 Sep 2025 13:48:23 +0900
Message-Id: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJc9ymgC/3WOwQ6CMBBEf4Xs2VVaUhM4+R+Gw1JWaZCC24oYw
 r+LcPb4JnkzM0NgcRygSGYQHl1wvV9BHxKwDfk7o6tXBp1qk+bKoCWPQm8UHsi2aLUiqrSxVil
 YpUH45qat8FruLPx8rb1xD6GiwGj7rnOxSDxH9DzFU0fOw09oXIi9fLZDo9qMf9ujwhQNk86zy
 p7rLLu0LJ4fx17uUC7L8gXVYiH+3gAAAA==
X-Change-ID: 20250915-can-raw-repack-c21aab25cc11
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=l2X5WYYtJ+/RmiIVJAaaTIO6p45pcgFI+gmCNpnaKUk=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnbFeruJh9tBN+G/dXvtY7gc/s8u5tsg9XT517lvn4v
 mfqy+UCO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAExE+Akjw+wgbmW93RXJK0QY
 SyplbTTLutqexGgG3z3vmbbBxyTyBsP/wOD+HdXpi1Zemn0yckl74pUPdZO/LUk60JPN13T799O
 LLAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

A few bytes can be shaved out of can raw's struct uniqframe and struct
raw_sock.

Patch #1 reorders struct uniqframe fields to save 8 bytes.

Patch #2 and #3 modify struct raw_sock to use bitfields and to reorder
its fields to save 24 bytes in total.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - in patch #2 also add raw_sock->bound and raw_sock->join_filters to
    the bitfield.

  - add Oliver's Ack tags.

Link to v1: https://lore.kernel.org/r/20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org

---
Vincent Mailhol (3):
      can: raw: reorder struct uniqframe's members to optimise packing
      can: raw: use bitfields to store flags in struct raw_sock
      can: raw: reorder struct raw_sock's members to optimise packing

 net/can/raw.c | 65 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 27 deletions(-)
---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250915-can-raw-repack-c21aab25cc11

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


