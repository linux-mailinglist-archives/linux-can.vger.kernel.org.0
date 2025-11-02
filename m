Return-Path: <linux-can+bounces-5296-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F4C2980B
	for <lists+linux-can@lfdr.de>; Sun, 02 Nov 2025 23:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728231889661
	for <lists+linux-can@lfdr.de>; Sun,  2 Nov 2025 22:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281921B191;
	Sun,  2 Nov 2025 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2dD78wd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AF212FB3;
	Sun,  2 Nov 2025 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762120944; cv=none; b=g8HXPlKxThvvxxdjMCfTX+rRUj0GfhUtsIBkkGL6iJzoIkZ8K8t1QGQ/ZN2qrIUR0drXcdD2GEErHNOSKtaYRKW1rv/gM+ioE6Hah1TJiAEbEjHTNI/iaZIQbOvpAM7S5p2cMV/hf8nS15WyI4+zlIN6NKKIi5AfCrDr9gSfCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762120944; c=relaxed/simple;
	bh=I3VUIZBrzTnSKzceauS1D6vvM8dyX5gyoyosn+e2Ye4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NNP1TNCZvhlZdw1ZVcsNFWwDZB7YQOFm/l97FdXjEf2+Ea0b+FWwnEyNwCvZkiKobMxZLZsQp6odIKJYzjeyQ2S1kfimnEw3eMUlbmkMudxUcdv6jwxJwnjIuUAMXKJZgmdaRjrFPNqetc9I/qYGiVR9SLfNHWBMJiFTd/j8Ef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2dD78wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EEAC4CEF7;
	Sun,  2 Nov 2025 22:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762120943;
	bh=I3VUIZBrzTnSKzceauS1D6vvM8dyX5gyoyosn+e2Ye4=;
	h=From:Subject:Date:To:Cc:From;
	b=r2dD78wdaTbmnnTX+9vtBBAnsTkeD6PVYUPIRsPuzz+BijpZyb3irXGhQNkxqYXaq
	 uN4h296C1PEf+jT3OuIX5D4u/JH3585Fq0bjFAlGErlcX4bj/ddImcwKT6neUyHhdI
	 9Cz/kTFrpP5dkuXXKOhqxlWOvzh82VvlrkvZVSTy+90fBP9y0tkIXbMWsGz/k00ncw
	 uFwvro7bUIOm0ENBvq6E/3krakvD51Rn8/rNZnCrOZt1S1MDYSdBK6xsLhVMwwQPQC
	 jXWAHr/bh4exvCJktZS+A/vFQRD+tAPp8pQUOg/jDRdQOonmARAin3Li5bd17eemke
	 sDkAdI4FBXPGg==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH RFC 0/3] can: calc_bittiming: add sample point calculation
 for PWM encoding
Date: Sun, 02 Nov 2025 23:01:21 +0100
Message-Id: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLUB2kC/z3Myw6CMBQE0F8hd21NWx5ityZ+gFtDSCkXbaQF2
 4okhH+3PuJyZjJnAY9OoweRLOBw0l4PNga2SUBdpb0g0W3MwCnPGaOcjE9Te2nGHutx0DaQsuS
 palLVZvke4m102On5Q57hdDxA9S0d3h+RD7/lr4sk2hnjfE+UtHNPLIZe2xtpVJFR2TFa7FIx8
 bfdSI9EDcboIJKp2LKSOMWhWtcXIeUBOckAAAA=
X-Change-ID: 20251102-pwm_sample_point-8823cb3cd459
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=I3VUIZBrzTnSKzceauS1D6vvM8dyX5gyoyosn+e2Ye4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnsVx6IKp/2bbya9GanxHRDPmMDX8ljNpweC3vaHrCx7
 3fez7mko5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwES+zGBk+CMUkG3xtatc3iD6
 0kK3F10C+w5+7KuQfPHjFo87W0IxF8P/3B0Ce+N+irlIZd/T2CAptF3J9sqlhIlP275sKXY9+Y+
 TBQA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

I wrote this series in response to Oliver's feedback in [1]. I am
sending this as an RFC based on top of [2] for the moment so that we
can discuss this separately. The plan is to merge this to the CAN XL
branch once we reach a consensus on this part.

Patch #1 and #2 are refactors, patch #3 introduces a dedicated
function for the PWM sample point calculation.

[1] https://lore.kernel.org/linux-can/743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net/

[2] [PATCH v2 00/10] can: netlink: add CAN XL
Link: https://lore.kernel.org/linux-can/20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org/

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Vincent Mailhol (3):
      can: calc_bittiming: get rid of the incorrect "nominal" word
      can: calc_bittiming: add can_calc_sample_point_nrz()
      can: calc_bittiming: add can_calc_sample_point_pwm()

 drivers/net/can/dev/calc_bittiming.c | 68 ++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 23 deletions(-)
---
base-commit: ffee675aceb9f44b0502a8bec912abb0c4f4af62
change-id: 20251102-pwm_sample_point-8823cb3cd459
prerequisite-change-id: 20241229-canxl-netlink-bc640af10673:v2
prerequisite-patch-id: 6b3294205bd76b38257516c63b7001ab242c9b62
prerequisite-patch-id: 56431d12edcc0f325cf5204bb6868742c462c0ed
prerequisite-patch-id: 1547fd7ea8f1937f0491cfc0996b09890f850991
prerequisite-patch-id: 1dae270b0454352e46b927f71d1b47ff2bf7a49e
prerequisite-patch-id: e4d43de873dfdefc023a0b86e397b37ea2b9e9a3
prerequisite-patch-id: 4f3db477ff411effe70075c59ae6eac04fc65600
prerequisite-patch-id: 148dbfce9d3bb09537087ee93e60bb7819bdadee
prerequisite-patch-id: 7996539e26d449e8db260425c7287b4dce8cdf35
prerequisite-patch-id: 42215044df6a63fff07c7a7d771d7dc375cc8b0e
prerequisite-patch-id: 640ebf8ac8a1d114dcb91e6c05b9414bd09416fc
prerequisite-patch-id: 84ee5e4f937f8e4cd97833d601affea78fe55914

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


