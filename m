Return-Path: <linux-can+bounces-5765-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B32C92BD0
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA0A43547F7
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9032D8760;
	Fri, 28 Nov 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bwKLAWJJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="u7Fkbf2R"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E10262FD3;
	Fri, 28 Nov 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349063; cv=pass; b=RcCBwdjK9zOZM4hCDik4DxIcbfFFp/A2D1ERb+wdakW+aYfrDq3sxyjDOYGL5UgTxobpAaWJi0HxzcEgYXgPnv3WG87KaQ7AKvArFq7buY7nt6HsHXh4Y0eSQzip4RO7Npsk91fMt4a6w5azzgtW2TH/xJ372LJM66qHJXMKhvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349063; c=relaxed/simple;
	bh=00qHpGcYsnRHFZ/hJQDrQaNHJwC4FuA18+Z87NcKvmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DoDODUawvzz8Cz0L4dBexV83gcohd2cfoh9g+2eYIjbZgJTkbUNn4aOb1IiESpEqqLKURmej+iFCJfCh7A1/ZVKNnvhIGWdip+V/cqRs2jbwPxXUtLr+iquiFP6Q4KyAyTQ9XFYBb7fNKjthOzGvw3Kh58o0j48WjCC87hQsAp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bwKLAWJJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=u7Fkbf2R; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764349040; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GraZ0NZqRG32xFz3iXlGTiWJEzb48Z23HAItdPvSv+Dk/dohJaut/bl/AHbQ7J/mkM
    kuWVKh/tQVpOoVWdBu5jdU3K0vbW2i7CQUYxp/QYWAaqCBQzQPy0YRXQAUgs7BWonYwK
    9iGUG7Gtw83glUfeYRAxUeucGGjaCYbaexKoqkA+V09e9dzgm5OMU6NiQzfm3/jFOkiN
    0ZlmHysQobDYilSObN5MZHnNhk02HnfP4OLMZG3WxGE7oAtDaUosCn0GgIlVaCQF5vhp
    KoMC4JKdhgTAFc4k2GZDjFRx3W/fqslBwmFJvTIbO0C+sSlSTuN0WdtMvGFQkUGDZBUI
    9iQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764349040;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=sis8jRUO81YPvS9DuorQk6EiAq16aTa6lqKbQn3SFuQ=;
    b=STaelqAxb4sA36zUWD+1BHv+xzhUZzSSdZb7tlMfVHlkjbqv9Jtmq66iStUh9GlQL2
    wVCIyIHF4DtSJrXvJ9/tOz2lpfPRoUn6cMKlbFz+Y1pveLiEJT6jyZxzXVVqAUFrzN09
    MnwrV12S8/zQ9qb+OMcNLHgOMdS+xsWiCL/fAW1BAR3IHBUlAEWNwf2rPD9FYYnn4N9J
    8Q7cKt7heO3+QJbWUyREA3egl3PdCFfqqrvW3E3ZyovX8Za+SqFEQGBqBJuWVrZb8nTj
    MHkcYsZ+AoavcoUNzUL2jHJfZagRseIt+Yfu2VkVrbhJ9yUYN0+9oMP9wMDRRkihYRUU
    fpVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764349040;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=sis8jRUO81YPvS9DuorQk6EiAq16aTa6lqKbQn3SFuQ=;
    b=bwKLAWJJ7QJwarI4IjhCACJ/cFzNGVlCHywmuW6oXMiJfpom2QvsUyO7BQDTNDEdN1
    1nu84PTcC31Hg8qqKAcaKr+HTghVIiJkk437IbIhjQcKB4dUi3UxKGXxQhAmeeaj4bfX
    xuBV/rGUqf/xflze76ro/TwPX04hP+/9VzEqfbNmqdl2HHafPmZY+VEQQ7WyAfZL05wS
    L6tR4JEObPuzyJv2F1VJ61ECJnuBqiDY3iuzd/MvYKhnLjQHPlAyplvRR1+L3v1BtKdL
    xRENu600zpTwHMGdF5wF5QbRdQ+aw99n5xeGTBeewN1mkv9x/aLCg6h3ZRKkSWatJ/Bv
    Qfzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764349040;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=sis8jRUO81YPvS9DuorQk6EiAq16aTa6lqKbQn3SFuQ=;
    b=u7Fkbf2Rea4LhJaiP1DuYYK9AemzS6wGqY8uyCePbDQwKlN7DsKGg0xHjcArQ08/fh
    bFhQqL2y6xryhVIlG5DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ASGvJgbc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Nov 2025 17:57:19 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	kernel@pengutronix.de,
	mkl@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [can-next v2] can: Kconfig: select CAN driver netlink infrastructure by default
Date: Fri, 28 Nov 2025 17:57:12 +0100
Message-ID: <20251128165712.22306-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The CAN bus support enabled with CONFIG_CAN provides a socket-based
access to CAN interfaces. With the introduction of the latest CAN protocol
CAN XL additional configuration status information needs to be exposed to
the network layer than formerly provided by standard Linux network drivers.

This requires the CAN driver infrastructure to be selected by default.
As the CAN network layer can only operate on CAN interfaces anyway all
distributions and common default configs enable at least one CAN driver.

So selecting CONFIG_CAN_DEV and CONFIG_CAN_NETLINK when CONFIG_CAN is
selected by the user has no effect on established configurations but
solves potential build issues when CONFIG_CAN[_XXX]=y is set together with
CANFIG_CAN_DEV=m or CONFIG_CAN_NETLINK=n

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Reported-by: Vincent Mailhol <mailhol@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511282325.uVQFRTkA-lkp@intel.com/
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

v2: In fact CONFIG_CAN_NETLINK was missing too. Reported by kernel test robot.

---

 net/can/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/Kconfig b/net/can/Kconfig
index af64a6f76458..69cab889186c 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -3,10 +3,12 @@
 # Controller Area Network (CAN) network layer core configuration
 #
 
 menuconfig CAN
 	tristate "CAN bus subsystem support"
+	select CAN_DEV
+	select CAN_NETLINK
 	help
 	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
 	  communications protocol. Development of the CAN bus started in
 	  1983 at Robert Bosch GmbH, and the protocol was officially
 	  released in 1986. The CAN bus was originally mainly for automotive,
-- 
2.47.3


