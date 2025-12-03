Return-Path: <linux-can+bounces-5810-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5701ACA14B0
	for <lists+linux-can@lfdr.de>; Wed, 03 Dec 2025 20:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74460320504A
	for <lists+linux-can@lfdr.de>; Wed,  3 Dec 2025 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F45F3161BA;
	Wed,  3 Dec 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/ue4qte"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124D314B8A;
	Wed,  3 Dec 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786354; cv=none; b=FWKyv3G0MWBT1nmXPzQ6bNyi2rkj1d6TJQT1vs0/wPVlT5xPVHrL87AgroL0f3x6eMCDuAItbfeMg6bzAfHxB0kyPZx/J8la7uEPNzNyS0oTBdcjRa97xpXLbkQLcs7tcPy+eNhI1NY8qId9Kdc3eFnVuWBBNazOQ8mz6W2+ET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786354; c=relaxed/simple;
	bh=k1XqMR/MfZi4V/PExqNXtDjOhZZ2W9JTvNV+qxbIOh4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dulNCxr6nn4/r1xlOE1R0iRjYs2MxvIrbiSNLT1eocTlI02pj2K7oeAr6sHGFI6xlZDvQa8QHBnGgbunQHoYvuANs0CrOKWMJAOKiVDGRFnWPIg2wkVfmXkiE5Tvf72hX3AcWifjxDqGghxTmL1J0aUN5HeIhn1dsY8nfaZup5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/ue4qte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E401AC4CEF5;
	Wed,  3 Dec 2025 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764786353;
	bh=k1XqMR/MfZi4V/PExqNXtDjOhZZ2W9JTvNV+qxbIOh4=;
	h=From:Subject:Date:To:Cc:From;
	b=o/ue4qte235+FhH3o5nMWImZoWSw+TP8j/7mv//Q8tGA+Z+tgAN+AlOeTk01QNphx
	 kQ0jObtPjU8HF7SmcgvI44Rzqpq+sNvB0VEorgmMqj62CFtXTWpiatqs+TfB/Bj4WR
	 ldCbmOxRdKZbHXLf8GID43rX7cBT38IFO6B8eDs7AWMon4Q3ePS3aLjB5YnNqNDZqh
	 mjz0i1fMWv0edRj3HrPXqklGLrZ6BwP0j89nWlULtB7UVFJoyilj95Hl1OxDo0oQF3
	 CBsWbmfyf7QaZHXzjZgnt7KWkuUBvsMSp4tOrOAD9QBWa6jYraluKYiG6iWCMgl3GP
	 B0pTcgjues6ug==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH iproute2-next v3 0/7] iplink_can: add CAN XL support
Date: Wed, 03 Dec 2025 19:24:27 +0100
Message-Id: <20251203-canxl-netlink-v3-0-999f38fae8c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFuAMGkC/12OQQ6CMBBFr0K6tqYziIAr72FcNO0ADaSQtjYYw
 t2t3RhZ/vz/3szGPDlDnt2KjTmKxpvZplCeCqYGaXviRqfMUGAlWgSupF0nbilMxo5ca6gllZD
 ahiVmcdSZNfsezCxufgXCtF4De6Z6MD7M7p2vRcijrxgA24M4Ahe8vXaohKouAuA+krM0nWfXZ
 1XEH47i+FfEhGupO6kagKbGP3zf9w9N8ys5+QAAAA==
X-Change-ID: 20250921-canxl-netlink-dd17ae310258
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>, 
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=k1XqMR/MfZi4V/PExqNXtDjOhZZ2W9JTvNV+qxbIOh4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkGDZPFGW3ZtTVTV+ryfJl+/739s6qvaV1/nByz/23fu
 C3yyvzyjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABMxucfwz97Tcm9yo8jC3omm
 X3fWrTv57FeMU+/+ZsbeaV2r3xTcm8Lwv+QSh82a01ODNlYV726aIyc9OXFCvKJEn6N3/AYOuW2
 v+QE=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Support for CAN XL was added to the kernel in [1]. This series is the
iproute2 counterpart.

Patches #1 to #3 are clean-ups. They refactor iplink_can's
print_usage()'s function.

Patches #4 to #7 add the CAN XL interface to iplink_can.

[1] commit 113aa9101a91 ("Merge patch series "can: netlink: add CAN XL support")
Link: https://git.kernel.org/netdev/net-next/c/113aa9101a91

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

---
Changes in v3:

  - Patch #5: only use string literals in print_uint(). To achieve
    this, remove the "is_xl" parameter from can_print_xtdc_opt() and
    instead add can_print_xtdc_opt().

  - Reword patch #4 to #7 subjects.

Link to v2: https://lore.kernel.org/r/20251201-canxl-netlink-v2-0-dadfac811872@kernel.org

Changes in v2:

  - add the "iproute2-next" prefix to the patches

  - s/matches/strcmp/g in can_parse_opt()

  - Patch #3: "s/milli second/millisecond/g" and "s/nano second/nanosecond/g"

  - Patch #6: s/XL-TMS/TMS/g in print_ctrlmode()

  - Patch #7: Remove a double space in patch description

Link to v1: https://lore.kernel.org/r/20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org

---
Vincent Mailhol (7):
      iplink_can: print_usage: fix the text indentation
      iplink_can: print_usage: change unit for minimum time quanta to mtq
      iplink_can: print_usage: describe the CAN bittiming units
      iplink_can: add RESTRICTED operation mode support
      iplink_can: add initial CAN XL support
      iplink_can: add CAN XL transceiver mode setting (TMS) support
      iplink_can: add CAN XL TMS PWM configuration support

 ip/iplink_can.c | 349 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 331 insertions(+), 18 deletions(-)
---
base-commit: 1a909dbde03c3f53612cd16dc1c8cb8d58931364
change-id: 20250921-canxl-netlink-dd17ae310258

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


