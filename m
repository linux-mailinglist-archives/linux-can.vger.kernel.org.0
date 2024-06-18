Return-Path: <linux-can+bounces-783-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E990D8E4
	for <lists+linux-can@lfdr.de>; Tue, 18 Jun 2024 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F409B2979E
	for <lists+linux-can@lfdr.de>; Tue, 18 Jun 2024 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77524152511;
	Tue, 18 Jun 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lc9PVF+p";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LS/OLGrv"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF513A89B;
	Tue, 18 Jun 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727166; cv=none; b=q9jPsWB2jZdeHUEc6Ns26O26em19b8mQ1pwlZ35ym+zdjpfj9XTNTy8xGslJgifvFqkScKRUBwla8AwtOze33nvCYatqU2YaTFMZA/Za4LytsKqJ2oEbElDpKqJFg2xgfGwyOZFahSmgiksSqalzEjU8jeFEJkIZ/c9+aenghs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727166; c=relaxed/simple;
	bh=qNULmo001mC5yL2uC9neAijsJRYb5joYOHW/sq9OTls=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=cSlRQ90jpS7cD6EtM0TXBTMxhqgnTQZM07O6dOZSqmblb5OiS4N6zBKcsWq9SpkIk7ggIxCfslug498hfe8QAHCFZFo1toYqQsfEGzDnGCdezd4ygktcCeaN+yWxgFtNbcF4EMdbveHlSxiNqmf86wsPi1XcmI/+lNl3SlV8dPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lc9PVF+p; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LS/OLGrv reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718727163; x=1750263163;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=qNULmo001mC5yL2uC9neAijsJRYb5joYOHW/sq9OTls=;
  b=lc9PVF+p//dq3Jl8gPUS0lGu9UN83ZYr6lB7KOqemgeSXB+WzW8XWmOi
   4jGqGqO2+dHZQHedOScRo5OKAeqoQwOEG4RsSOmrXoaW2Hpl3Sfpt7XkO
   BHZf5R+eMv1texL/VpjI+1/0jzLdQRzd1S8no4bq9Ihb41Op1CbF/XJax
   49hqxcLwGZ1P6S1PeJremc2Cu42C1Mu358L1Ez3q6aYGV9z+fZ522aHWU
   A2sAo6lY9DLwhnZq9OUxd8r7XaKWEcKYhTUK4d/BZ8ENsEaYCeM59+R4Q
   oPOJ2sk7bHTfM6zJvjcrrn8oRRt8P1yrh1Ejgb4agCaYP3+E8cZyUf//e
   Q==;
X-CSE-ConnectionGUID: UFIXNrYPRUOnvkwpxts+4w==
X-CSE-MsgGUID: orx72WeMR0idy2RCELZc2Q==
X-IronPort-AV: E=Sophos;i="6.08,247,1712613600"; 
   d="scan'208";a="37457616"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Jun 2024 18:12:35 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B5051664C9;
	Tue, 18 Jun 2024 18:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718727150;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qNULmo001mC5yL2uC9neAijsJRYb5joYOHW/sq9OTls=;
	b=LS/OLGrv/yld6GBB/DMqXy8/DiycpIH+FNzKfCT7A2THBG0TLcjyMVprzeFtT/JA8GS/5A
	7KwK2puAK0sVidAs3x6YI47wboRSfT3jPJhZZeNSKziSkfHl6iR2Wh1rIayE50KgvOuadq
	8Pd0CcW7N0DZOLiK1eVZAIQutJ74AyAVm7aiycrcyNL5esZ7IuEoLGm5WnpNmJOOkQHcA7
	ASjTte6NPB6sqiwfgALZS3ZIFWVQr+lj7p0RmvtNm9VLtKwVvRJUAQki0VQIYSpyWoXapv
	KaWGdHyFCdALxvIbx46/q/6l8k7dV0GmdTnVR6MQMA01ZCrN7BWKhxQXGqGzpA==
Message-ID: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
Subject: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Tony Lindgren
 <tony@atomide.com>, Judith Mendez <jm@ti.com>,  linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,  linux@ew.tq-group.com
Date: Tue, 18 Jun 2024 18:12:27 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi Markus,

we've found that recent kernels hang on the TI AM62x SoC (where no m_can in=
terrupt is available and
thus the polling timer is used), always a few seconds after the CAN interfa=
ces are set up.

I have bisected the issue to commit a163c5761019b ("can: m_can: Start/Cance=
l polling timer together
with interrupts"). Both master and 6.6 stable (which received a backport of=
 the commit) are
affected. On 6.6 the commit is easy to revert, but on master a lot has happ=
ened on top of that
change.

As far as I can tell, the reason is that hrtimer_cancel() tries to cancel t=
he timer synchronously,
which will deadlock when called from the hrtimer callback itself (hrtimer_c=
allback -> m_can_isr ->
m_can_disable_all_interrupts -> hrtimer_cancel).

I can try to come up with a fix, but I think you are much more familiar wit=
h the driver code. Please
let me know if you need any more information.

Best regards,
Matthias


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

