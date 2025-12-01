Return-Path: <linux-can+bounces-5797-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C896C9974D
	for <lists+linux-can@lfdr.de>; Mon, 01 Dec 2025 23:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26C4E3411FF
	for <lists+linux-can@lfdr.de>; Mon,  1 Dec 2025 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62734287268;
	Mon,  1 Dec 2025 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHr8s/1n"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565036D503;
	Mon,  1 Dec 2025 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629786; cv=none; b=ZDXp8gTgHqz/ge/mjZ7UZX8EFs1lX6HZDbUgO1Ou6D2fCAwZYx76/C6BTcpV2CWAxtFLmvigtHr40kR90hYEWOod4g6iz6Q52uT0Lizl57zzRr9V6MxN2CQnq2u5NcGzxcZkxoZtws7Qp8Bbuw/ScKF1ctbKNmaNTQvpfFGoeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629786; c=relaxed/simple;
	bh=XIbBQv8lKAJ3QJv++NIRTKttZUBKXNi0mzQvos8QTzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q2lP+MBa0wl2IKfMFBBh08jRUttlFCACavSEeLDc2xAdDQHpKpZCv4yJdU7VdH4VfXpEo0lARlsAO+b606rxxtt3bjX6Sg7rMqxSCDP2PiOVA9iIEO3tloaynzB3ZMFovpoErDdhDnlnGuT0ngfhqg7exuBEIs/Z8/VOxsDBFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHr8s/1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56658C4CEF1;
	Mon,  1 Dec 2025 22:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629786;
	bh=XIbBQv8lKAJ3QJv++NIRTKttZUBKXNi0mzQvos8QTzs=;
	h=From:Subject:Date:To:Cc:From;
	b=ZHr8s/1nPbsJOQ7S8EccPJwYnGfuh6tlLhBnHIWM8XtYWVRlO/MPcPRmMhbHyApGB
	 D6yLuixSkKWPcryQJvBo+N68QImwsuiQ4N1V4IAjYPGOkXKwekDG9V7ehlrYirIodD
	 7wYBY3V34qsCm+BbvMAFR7CgQ4R1W0NgQOx4nvMnHcvznR17FVjW7pK+OTiZ3y2HqJ
	 IK1iK0Ow74cVdQ4061YyPgBp7g66a92VqptuMta7m4sGoh2xFDLe30efw3/iB0u5Uq
	 wYKgj/u/6wzQqs5ceNXwXDLdOC9/t3I5iTenQDcckUpagAFLVdK5mpsROaY0N6VOOD
	 ZS+9X3WXCr1eA==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH iproute2-next v2 0/7] iplink_can: add CAN XL support
Date: Mon, 01 Dec 2025 23:55:08 +0100
Message-Id: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMwcLmkC/12NwQ6CMBBEf8Xs2ZruKiqe/A/DgZQFNpCWbCvBE
 P7dytHj5M28WSGyCkd4HFZQniVK8DnQ8QCur33HRpqcgSwVtiQ0rvbLaDynUfxgmgZvNZ8x0zv
 kzaTcyrL7XiCThndiyu0lQZVxLzEF/exvM+6lnxiRyj/xjMaa8tqSs664WMTnwOp5PAXtoNq27
 QvVERuVugAAAA==
X-Change-ID: 20250921-canxl-netlink-dd17ae310258
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>, 
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=XIbBQv8lKAJ3QJv++NIRTKttZUBKXNi0mzQvos8QTzs=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJl6Mr/cf10KPbSGSVxbo1/M0OSFolVM+v+1/5d1l+fmm
 sllNb7uKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMJHykwz/TPi3Ox48oRh7WKEo
 gt2vScNnvfzetqpamYMu24Nil3drMTJM+SMl2zjJYopNGu/aIw3da9dYHP66udlKqchkSqhppRg
 /AA==
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
Changes in v2:

  - add the "iproute2-next" prefix to the patches

  - s/matches/strcmp/g in can_parse_opt()

  - Patch #3: "s/mili second/milisecond/g" and "s/nano second/nanosecond/g"

  - Patch #6: s/XL-TMS/TMS/g in print_ctrlmode()

  - Patch #7: Remove a double space in patch description

Link to v1: https://lore.kernel.org/r/20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org

---
Vincent Mailhol (7):
      iplink_can: print_usage: fix the text indentation
      iplink_can: print_usage: change unit for minimum time quanta to mtq
      iplink_can: print_usage: describe the CAN bittiming units
      iplink_can: add the "restricted" option
      iplink_can: add initial CAN XL interface
      iplink_can: add CAN XL's "tms" option
      iplink_can: add CAN XL's PWM interface

 ip/iplink_can.c | 338 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 314 insertions(+), 24 deletions(-)
---
base-commit: a4861e4576d84c12122235d0abb7899784a6f75a
change-id: 20250921-canxl-netlink-dd17ae310258

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


