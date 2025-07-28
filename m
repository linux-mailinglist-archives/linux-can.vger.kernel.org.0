Return-Path: <linux-can+bounces-4186-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B26E4B1403E
	for <lists+linux-can@lfdr.de>; Mon, 28 Jul 2025 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF541882775
	for <lists+linux-can@lfdr.de>; Mon, 28 Jul 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D9C26FDB2;
	Mon, 28 Jul 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOF3PHoL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2C269D18;
	Mon, 28 Jul 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719834; cv=none; b=L3bvekL0jOVdsvw7/QLSDFyCnrpAGR5nYLHxumBE2Cj7ds1xw6LnZtxpJO7AdZmR+/W6v3IjMKXf63xfg5W+VgDH23/OXx1byqwDvmKzud9e4soaGOIiWI4WlOhqXUKM8flDfJy0aL2HUAFnQLd9AkmyEPF+BPQykyBV17Sg1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719834; c=relaxed/simple;
	bh=DYX7A3/YZVVtNkT3oxxllNojSjEoxwFhWIFQA/m7loU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q/ln3STEmuERub0FsoDu4ktmhAr4KCjRnzzHJe2BTvE1b3NoTVSaD0zPzvOARnG0+sBLO1hScQYz2nk5G9idHBo2S51ojTpTcdJtDzENhyq9x0t6S32AJWf8gaRLjeel4C4RpIUfEsNjM8HCqXlF1IiPnoucCJBqP3ePR9LJqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOF3PHoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC16C4CEEF;
	Mon, 28 Jul 2025 16:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719833;
	bh=DYX7A3/YZVVtNkT3oxxllNojSjEoxwFhWIFQA/m7loU=;
	h=From:Date:Subject:To:Cc:From;
	b=lOF3PHoLYcSc80KNnx2MyeIgA1ZqVtOrQ+TgJkgFjM1lSOpfxbl4Z/m960apnBfb7
	 5TC8J5ebY57GU1yXYlplnU5laFNY5rWLGxwMFrRWKzoVbDo7IzpxkcGonzhQrJDhps
	 6xSPQR8CLj3HzwUHv35CMiXHvPY2dHP+wpN4AitsdlFrCjClwqfmH1Z5MMq1etSVOq
	 QjVoDvx3O2XwCrw7sCd/jofNFjVABy5HDffRAWYnYSw9i+gPWuCYiOXBZJd0q1i9o1
	 nX5D5GI97f34mFNz8H2kYHlDu4/tJRQwXtnZPsAKHV90TIGkHz6BglZA/I4ik+G6Lk
	 4QIZv5t+bdzTQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 29 Jul 2025 01:23:18 +0900
Subject: [PATCH] can: canxl: add CANXL_PMS flag
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPWjh2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNz3eTEvPiS3GJdk6QUC1NDg6Rky+RUJaDqgqLUtMwKsEnRsbW1AMB
 3+bJZAAAA
X-Change-ID: 20250727-can_tms-4bd8510bc9ce
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Robert Nawrath <mbro1689@gmail.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3701; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=DYX7A3/YZVVtNkT3oxxllNojSjEoxwFhWIFQA/m7loU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBntS0SqVI1+2KUfW614f118ymLHluIbZu9vPJCaE/7jz
 smJCj/ZO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAExkLhPD/8JnW1KcVL/aL1l1
 9eLPfk21HQt+/PDaPIG3Y/mVZxky34IYGS5NWrZa1K7fc13lN+trPrknMjgv+qftdN/dxTb72Be
 jRF4A
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The Transceiver Mode Switching (TMS) indicates whether the CAN XL
controller shall use the PWM or NRZ encoding during the data phase.

Contrarily to CAN FD's BRS flag, CAN XL does not have an explicit bit
on the bus to indicate the TMS. Instead, this is done implicitly: the
transceiver will automatically detect TMS on the fly if the frequency
on the ADH bit is higher than the nominal frequency and this until the
DAH bit on which the frequency returns to back normal. For this
reason, the TMS is something which, same as the BRS, should be
configurable at the frame level and not at the netlink level.

The term "transceiver mode switching" is used in both ISO 11898-1 and
CiA 612-2 (although only the latter one uses the abbreviation TMS). We
adopt the same naming convention here for consistency.

Add the CANXL_TMS flag to the canxl_frame->flags list.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
The CAN XL did not make it on time for the 6.17 merge windows, sorry
for that. Regardless, I finally went through the CiA 612-2 document. I
have the PWM verification and automatic calculation working fine
locally.

But before that, I want to sort out this TMS thing. That is why I am
sending this unique patch. Once this discussion reaches an end, I will
fine tune my work-in-progress accordingly.

Looking at the past exchanges, this TMS was the missing piece. I was
already troubled by this when reading ISO 11898-1. That document makes
it clear that the TMS can be deactivated but does not clearly point
out at which level (netlink or frame). The CiA 612-2 clarified this.

So this CANXL_TMS flag partially replaces the CAN_CTRLMODE_XL_TRX. I
say partially because I still do not fully understand if there should
be an option to fully deactivate the TMS at the netlink level.

My gut felling is that the TMS is intended to work in a similar
fashion as the CAN FD's BRS. In CAN FD, we do not have a
CAN_CTRLMODE_FD_BRS to tell that FD should operate only using the
nominal bittiming. And so, I do not get why CAN XL should be different
and have a CAN_CTRLMODE_XL_TMS (or CAN_CTRLMODE_XL_TRX).

Stéphane and Oliver: maybe the datasheet of your CAN XL board have
some additional insights? Did you see a register allowing to globally
deactivate the TMS (i.e. not only at the frame level)?

Finally, on a side not, now that I have my kernel.org account, I am
changing my e-mail address from mailhol.vincent@wanadoo.fr to
mailhol@kernel.org. The wanadoo.fr address was my first email which I
created when I was a kid and have a special meaning to me, but it is
restricted to maximum 50 messages per hour which starts to be
problematic on threads with many people CC-ed.
---
 include/uapi/linux/can.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 42abf0679fb4854cfa4f29a575e49527461a20f3..4a81500c1a06a69707accbf66224da7285d9d282 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -193,6 +193,7 @@ struct canfd_frame {
 #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
 #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
 #define CANXL_RRS 0x02 /* Remote Request Substitution */
+#define CANXL_TMS 0x04 /* Transceiver Mode Switching (fast mode using PWM encoding) */
 
 /* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
 #define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */

---
base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
change-id: 20250727-can_tms-4bd8510bc9ce

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


