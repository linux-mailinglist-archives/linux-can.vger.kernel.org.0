Return-Path: <linux-can+bounces-5774-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD292C940C1
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 16:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A953A5C9D
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAA1C5D44;
	Sat, 29 Nov 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXXs2ZfF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306451AA7BF;
	Sat, 29 Nov 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430188; cv=none; b=rK/f38BGZ337X2+yWVi4RvdCcGi246E3qtkKEcIa0g7F0yi2dxVS8a11tECswc8U/z7bHrU57Y4pymvYmpanucDZEOmv0YwT6mRas6XhTYNwNqWswR+C3y2nKV62e1zlss3B/GpBsuRIArFOBfkMvtsZpnlBxlrb0qwfeTYML/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430188; c=relaxed/simple;
	bh=P67P7Vxu/VhC1mVWvQw/CPYPOPaXZcYq9zc29CVOzcg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jOLIQFpmRsgnx3kob+mZO9EmdhyZj/QiyGwMf6wdcPocaJfauPHvauj0JhegQ9aJ1A1Muk1EZBkQ6LF9k68ypsGUgZM20uHy85SkWF4m3Z5nbYDTKQcvikhxAg01Ew6fREbxO6Vcz6o1BjczmkZk09E2CnZva47gcuLQ4rTlusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXXs2ZfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E065EC4CEF7;
	Sat, 29 Nov 2025 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764430188;
	bh=P67P7Vxu/VhC1mVWvQw/CPYPOPaXZcYq9zc29CVOzcg=;
	h=From:Subject:Date:To:Cc:From;
	b=LXXs2ZfFExrDXn+p3su3Hgb68ncFCEhNo/dvG039sB6OD0kMgzgqm/HIN2ajTKP3W
	 xJyOfh+QybKw/2JHTbqtotkQHYImtvqU927WM54u1bBm89MDte4lqd1SLVhv5QwzQQ
	 41hGLgdeVaOpsbSr5JoY8BJJrxS82ieUR3SIfAPLbxPe6wZsXASDPUxADJdTiCfI1o
	 FxaGbJSIbhBzR8rcWuoH6NULVt3PAglM7bLrmFIhbB6J4uxW1VLuA2IiHFAn0o6kvU
	 UKO0KZBx/3jXttCj6i/hyxo0JqWPa50hIC8NgLZni+5rGK+KJ5lSqQ8NcIVPyoB24I
	 1mdiHeJnqaYOg==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 0/7] iplink_can: add CAN XL support
Date: Sat, 29 Nov 2025 16:29:05 +0100
Message-Id: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEERK2kC/x2MWwqAIBAArxL7naBG9LhK9CG61ZJsoRGCePekz
 2GYyRAxEEaYmwwBX4p0cQXVNmAPwzsKcpVBS93LSSthDScvGB9PfArn1GCwU9WOUJs74Ebp/y1
 rKR8OZEGDXwAAAA==
X-Change-ID: 20250921-canxl-netlink-dd17ae310258
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=P67P7Vxu/VhC1mVWvQw/CPYPOPaXZcYq9zc29CVOzcg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnagn79je/rjAzvM3A8Ei9ZdNzwut/FqtkufV5hvX+2H
 VCUzpreUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCKnQxgZ2q8aloS+esj6Wv1k
 6cLo6vc2fnf+nY4vXWfH+9xj1mq/64wMzyXWLUxU1tJ3f8Uk07OqullRyCL/j/Bt/d1/c5+tdJ3
 IDwA=
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
Vincent Mailhol (7):
      iplink_can: print_usage: fix the text indentation
      iplink_can: print_usage: change unit for minimum time quanta to mtq
      iplink_can: print_usage: describe the CAN bittiming units
      iplink_can: add the "restricted" option
      iplink_can: add initial CAN XL support
      iplink_can: add CAN XL's "tms" option
      iplink_can: add CAN XL's PWM interface

 ip/iplink_can.c | 338 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 314 insertions(+), 24 deletions(-)
---
base-commit: 69942d75ccb7c0fa041d194ab4cb0879e969c828
change-id: 20250921-canxl-netlink-dd17ae310258

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


