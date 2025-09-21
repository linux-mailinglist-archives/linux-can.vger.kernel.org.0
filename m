Return-Path: <linux-can+bounces-4772-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A38B8D69C
	for <lists+linux-can@lfdr.de>; Sun, 21 Sep 2025 09:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835F6442A77
	for <lists+linux-can@lfdr.de>; Sun, 21 Sep 2025 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674452D29AA;
	Sun, 21 Sep 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX6xxtlq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7362D249D;
	Sun, 21 Sep 2025 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758439990; cv=none; b=nO+cmndyg5q9ccCIQJvtrMrB3AEb5qTI4asTU+j0F9abV81HOkbU05twFjWfvCP8uM6L00+mjbiyKXWEcqF+QDQcFI+MRrCPapg7AzRaozPMEcMPGMM7rqLaDrsl8bJxaKp+AXQqeQQlmkTGZnbzQWbdlN2nrNU8PrhPuYtV/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758439990; c=relaxed/simple;
	bh=eXD1/uAXZPU4hdZy7YBqqH2R/cekJAyMpjS9zHYrNZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrwCB6khn6ADVI6YIbliYU1LYy2Argpq6G1JHerWJloygWPF/LhdiJ0mudgR+KS2F+orq4wf/f9py9Z8M6TQxqguxDx/JlRn1OVVzYc08dUhm14MAvCGTV5/zZovw0FHyRIZNjY6mddB2EFOjyr9914keMmOpOEdgSCEaPYw558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX6xxtlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7EAC116B1;
	Sun, 21 Sep 2025 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758439989;
	bh=eXD1/uAXZPU4hdZy7YBqqH2R/cekJAyMpjS9zHYrNZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fX6xxtlqrEiGPu2hkafYZXgsoBymPhdH+KDThVueqhTUKO7HP9CHyOiQvF1XXMTPi
	 TWjYhXvWOsOSpooVi6QXTG9YM50V5uQx8GbKImbqX7zeBxQTMrLY4JErY5bd4ULT8Q
	 CkzMKPaE+rJswI19GyhIuBQCZDt2ARZX8F6BSXL53CNx1m7SxictgveDuPGUAm9IXc
	 HwOM5PhT6/aWu1TQztoR+EIwL4P6aNKpUzUvbM3Dymk5r+qcBAogeiFMEuOwEnrpvf
	 C1kXe2G9MrALb5cEssACIk9ICiJJ6YXOvns85Mks67Qh6irG6aiJr1mjzqi9bDNLNG
	 UM3ouLkkRs6bQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sun, 21 Sep 2025 16:32:30 +0900
Subject: [PATCH iproute2-next 1/3] iplink_can: fix coding style for pointer
 format
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-iplink_can-checkpatch-fixes-v1-1-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, 
 linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=eXD1/uAXZPU4hdZy7YBqqH2R/cekJAyMpjS9zHYrNZY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnnV+lMEracfVB6z0+rhMaKjUv2Sr1zbHl5f9HlxoWZE
 kUX3qjM6ChlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRLB1GhhMO07d9krt37GIN
 /9WjmjlVmxv8Z53c8pRFOGr6Sg/n2wcY/hl38Z46zJ/wV+YY97ona6c0Vn2dvWFlbGzvqvKDsuG
 aX/kA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

checkpatch.pl complains about the pointer symbol * being attached to the
type instead of being attached to the variable:

  ERROR: "foo* bar" should be "foo *bar"
  #85: FILE: ip/iplink_can.c:85:
  +		       const char* name)

  ERROR: "foo* bar" should be "foo *bar"
  #93: FILE: ip/iplink_can.c:93:
  +static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)

Fix those two warnings.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 9f6084e63986bd05d25a050176f4640c30596b85..1afdf08825f3d9cbbb0454592d2ed7dc1388a6de 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -82,7 +82,7 @@ static void set_ctrlmode(char *name, char *arg,
 }
 
 static void print_flag(enum output_type t, __u32 *flags, __u32 flag,
-		       const char* name)
+		       const char *name)
 {
 	if (*flags & flag) {
 		*flags &= ~flag;
@@ -90,7 +90,7 @@ static void print_flag(enum output_type t, __u32 *flags, __u32 flag,
 	}
 }
 
-static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
+static void print_ctrlmode(enum output_type t, __u32 flags, const char *key)
 {
 	if (!flags)
 		return;

-- 
2.49.1


