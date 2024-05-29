Return-Path: <linux-can+bounces-688-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68508D32AC
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2024 11:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82363283D9C
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2024 09:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C434616A381;
	Wed, 29 May 2024 09:12:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF216A37A
	for <linux-can@vger.kernel.org>; Wed, 29 May 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973949; cv=none; b=KCDCkGLE6DhNowSv7Ui3qIMlbLFNsKR3gPlLKVypt9gBkTpjxNMkHRlAjapGe8FBRyFKKz4IHlrHORMWz4BJS2fXAdkJI9P2UxUU9zS4sv0kXEFrcHjWNruwLXgnUwSmXgdtzThDCPusvh/DfsNGmzg4doRip2tQ/TgV/nGwYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973949; c=relaxed/simple;
	bh=ciGSw9CwiJtOVA2c8bbGIC8epjuY/q7YZs5GBXMJOek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWc8YCYVmubKO0Vq+LZlBqKMqCqUxclyYLE2vueghNpTo3m+u32lqTb1oGgfj+/mt60t6caAyQ6h7aI9cHmcB85+o6kpn4cYkyCMnsVZDc/UXrc+egXp97fIHKOwJAMP2wa+wb8zihkBhBtrXP+C0xOypmivSigkGFaQ+dbAPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1b01:1838:131c:4de4])
	by michel.telenet-ops.be with bizsmtp
	id UxCJ2C0023VPV9V06xCJ26; Wed, 29 May 2024 11:12:18 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFL5-00GF9W-EB;
	Wed, 29 May 2024 11:12:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFM1-008w8W-Q4;
	Wed, 29 May 2024 11:12:17 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] can: rcar_canfd: Small improvements and cleanups
Date: Wed, 29 May 2024 11:12:12 +0200
Message-Id: <cover.1716973640.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This series containssome improvements and cleanups for the R-Car CAN-FD
driver.  It has been tested on R-Car V4H (White Hawk and White Hawk
Single).

Thanks for your comments!

Geert Uytterhoeven (3):
  can: rcar_canfd: Simplify clock handling
  can: rcar_canfd: Improve printing of global operational state
  can: rcar_canfd: Remove superfluous parentheses in address
    calculations

 drivers/net/can/rcar/rcar_canfd.c | 41 ++++++++++++-------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

