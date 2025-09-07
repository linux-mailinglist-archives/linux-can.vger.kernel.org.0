Return-Path: <linux-can+bounces-4500-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC08B47934
	for <lists+linux-can@lfdr.de>; Sun,  7 Sep 2025 08:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923EF4E0240
	for <lists+linux-can@lfdr.de>; Sun,  7 Sep 2025 06:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC31E552;
	Sun,  7 Sep 2025 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiTSMVdS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351B315D40
	for <linux-can@vger.kernel.org>; Sun,  7 Sep 2025 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757225027; cv=none; b=XhJhn5d2MhCkcDfhJIggm+5JyAHs9hrG4p4Q9wfwOD76sRWS9tOKDIZsYHNEc2qtzehE+SlMYm1i5Mq13IE0Bwp7JYq64yqoP1cEIv8xlj+xvq4pkcA3cUg9Rw6CeSWqVH1dp2j0yLSvf8vxjNLH23T8qWOaEQE9vBv3LmJuFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757225027; c=relaxed/simple;
	bh=G/tlvrocjEnzXkCzCnKyyHV42viLQKs5ZCFqmlqW/wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cICR3N1f9FiXuKn0GJ0yZvMt1FJNgVfpG5O8AozxCT05qQy+WCDvbzRFz9oDfrevCe0noXtsSMUIsC03V748U3I6+IoFEhdQ+Ox1kwfsEZiS41fpC+sOsMoNcxFiMrMjjM5vKBjPgcSBv4Nh3Znfz4kDsXIBYJyZEfXurK7mWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiTSMVdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0946CC4CEF0;
	Sun,  7 Sep 2025 06:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757225026;
	bh=G/tlvrocjEnzXkCzCnKyyHV42viLQKs5ZCFqmlqW/wI=;
	h=From:To:Cc:Subject:Date:From;
	b=hiTSMVdSPPmkxzWheNvppai/0lzQntU4NHsSb4cXwByXxSTocaE1L6wkQQT2+IO09
	 j2VfIg/aFxEh+rT+DinTNVs53gPDUeH0dyReZhQOgn/rSFyRICrK0p3hy3ZjH1JSel
	 n9W/GEvl89dXNZca69R0I2nBBzNplZRwZSbHyuZ2cTht4wrymodXL/ZrK2yt6iMZyn
	 VnToAYNaxHo6Doa+4EAEerU6Mm3NZJwEAm5YoQiLNPq0Ow3zZsJkcD54L3bO9uITgy
	 AgC3SbjOdsuRJUFEwdM4MA5mIFDlnpfPqu+MuciHNFwd/gp34Wm8OmHS62G78KQZIn
	 B0Ds8vyaB/V3A==
From: Vincent Mailhol <mailhol@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH can-utils] cangen: allow to use -m on classical CAN interfaces
Date: Sun,  7 Sep 2025 15:03:30 +0900
Message-ID: <20250907060330.441165-1-mailhol@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=mailhol@kernel.org; h=from:subject; bh=G/tlvrocjEnzXkCzCnKyyHV42viLQKs5ZCFqmlqW/wI=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDBl7FRgf+L5zPGHG+CDz2+3YTX5824J/2yx/ZPfTYOJk/ yPXgquvdpSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZjIHwFGhnnhp7WmCH/Y8pkz ZeL6TpkHX6o/KEhcmhze8oQjtHONphrD/zD/f79svPhvqJULNRa49nOfkH772H5m9ilJZcMP/F4 z2AE=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The -m option currently only works on CAN FD or CAN XL interfaces.
There is a logic to add CAN XL to the mix only if supported but CAN FD
is always forced.

Modify the -m logic so that only the options supported by the
interface are added to the mix. This way:

  - a Classical CAN interface only mixes -e and -R
  - a CAN FD interface mixes -e, -R, -f, -b and -E
  - a CAN XL interface mixes -e, -R, -f, -b, -E and -X

This provides a better user experience and also makes -m a good
default option for fuzzing any type of CAN interface.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 cangen.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/cangen.c b/cangen.c
index 95ac32d..5715447 100644
--- a/cangen.c
+++ b/cangen.c
@@ -180,7 +180,7 @@ static void print_usage(char *prg)
 	fprintf(stderr, "         -X            (generate CAN XL CAN frames)\n");
 	fprintf(stderr, "         -R            (generate RTR frames)\n");
 	fprintf(stderr, "         -8            (allow DLC values greater then 8 for Classic CAN frames)\n");
-	fprintf(stderr, "         -m            (mix -e -f -b -E -R -X frames)\n");
+	fprintf(stderr, "         -m            (mix -e -R frames and -f -b -E if FD capable and -X if XL capable)\n");
 	fprintf(stderr, "         -I <mode>     (CAN ID generation mode - see below)\n");
 	fprintf(stderr, "         -L <mode>     (CAN data length code (dlc) generation mode - see below)\n");
 	fprintf(stderr, "         -D <mode>     (CAN data (payload) generation mode - see below)\n");
@@ -574,7 +574,6 @@ int main(int argc, char **argv)
 
 		case 'm':
 			mix = 1;
-			canfd = 1; /* to switch the socket into CAN FD mode */
 			view |= CANLIB_VIEW_INDENT_SFF;
 			break;
 
@@ -777,7 +776,7 @@ int main(int argc, char **argv)
 			   &loopback, sizeof(loopback));
 	}
 
-	if (canfd || canxl) {
+	if (mix || canfd || canxl) {
 
 		/* check if the frame fits into the CAN netdevice */
 		if (ioctl(s, SIOCGIFMTU, &ifr) < 0) {
@@ -1084,10 +1083,13 @@ int main(int argc, char **argv)
 		if (mix) {
 			i = random();
 			extended = i & 1;
-			canfd = i & 2;
-			if (canfd) {
-				brs = i & 4;
-				esi = i & 8;
+			/* generate CAN FD traffic if the interface is capable */
+			if (ifr.ifr_mtu >= (int)CANFD_MTU) {
+				canfd = i & 2;
+				if (canfd) {
+					brs = i & 4;
+					esi = i & 8;
+				}
 			}
 			/* generate CAN XL traffic if the interface is capable */
 			if (ifr.ifr_mtu >= (int)CANXL_MIN_MTU)
-- 
2.49.1


