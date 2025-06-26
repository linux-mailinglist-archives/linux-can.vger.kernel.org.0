Return-Path: <linux-can+bounces-3903-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D56AE9F4F
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 15:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB5E5A335F
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F632E762B;
	Thu, 26 Jun 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="JMlikKow"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557C2E764B;
	Thu, 26 Jun 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945527; cv=none; b=MimzyQd6PiFS4t0Lws2GUoGyn+DKf0g2bCAYjf2ZV7a/5cADBmSWaKFud6sFutzUd4M/iDt1ZpQclexv4U8GiV7e1jsC1+Q0YnOik+u/n1C5PtZVS6DAfFQSPdR5CKBdiyWwMvDg6C1kCGrK/Mbr86/K08ot8BDeNb2H6zIjPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945527; c=relaxed/simple;
	bh=cAHj2gjaMwzRztjmDjs69yqAc2m3Ews7p2bnvtbAT9s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZChc3qI0aeyOHEg2c3fF80vPcnG/nu4PCrt9mZZU18cMaK8t0JJwQ2l8KkV4vWTUKvNldSvysIMR+i4KXgLUYSxW6Fa4IMSTlzq3OeS8e/0WArrRr6R2apnAlbrULgSUBqB5rMQrqzCwFtsTro3liRquryNGVbUCqYDY7mYL9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=JMlikKow; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750945512; x=1751204712;
	bh=cAHj2gjaMwzRztjmDjs69yqAc2m3Ews7p2bnvtbAT9s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JMlikKowl+lKWQcHw7nyAEJZiWixewtoGtrWaTi+Bx4sb/lraXNylA1/Pb5HM1B+q
	 a4jqvxnX6AU/ZRkCLQW7qdURSpFSnmqLRbNC6zQj8iNd1IkPYAxdNyMYGLaSY/Mj7l
	 nX/akAkgDxJJN2JlQAtA5z/XjD2KfQajV71zwpWHIMyE/kW6i0S5JzBNvjPhxEsITx
	 D/14hXzyJ4hm1ITol643oIIr41hv9D5ekT3YUBil9SeKUtT5paKfiURWEmXH0NHADn
	 ZEkJTrUHm9ZJvO3iMhRuqMujZs0+Toq+9qe8iQFLpGxTCU6OiuTb9GfrVROApyDnE/
	 2DxYR83spo4AA==
Date: Thu, 26 Jun 2025 13:45:09 +0000
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
From: Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Fengguang Wu <fengguang.wu@intel.com>, Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH] can: m_can: apply rate-limiting to lost msg in rx
Message-ID: <wldhiihvxg42yqaccizms4xfupfv2c7w7jec7jy6iht6dbnr7k@os6f2gyrr45m>
In-Reply-To: <d855c26a-1982-4fc6-9333-93df4a5a98d9@wanadoo.fr>
References: <20250620-mcan_ratelimit-v1-1-e747ee30f71f@geanix.com> <d855c26a-1982-4fc6-9333-93df4a5a98d9@wanadoo.fr>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: dc07e5f8eaa3e05c8410cb20b04564dbc2257281
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 21, 2025 at 11:13:33AM +0100, Vincent Mailhol wrote:
> On 20/06/2025 at 19:00, Sean Nyekjaer wrote:
> > Wrap the "msg lost in rxf0" error in m_can_handle_lost_msg() with
> > a call to net_ratelimit() to prevent flooding the kernel log
> > with repeated error messages.
>=20
> Note that another solution is to simply remove the error message. The use=
rs can
> use the CAN error frames or the netstasts instead to see if lost messages=
 occurred.
>=20
> That said, I am OK with your proposed patch. See above comment as a simpl=
e FYI.

I'm up for both solutions :)

@Marc what would you prefer?

>=20
> > Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>=20
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>=20
>=20
> Yours sincerely,
> Vincent Mailhol
>=20

/Sean


