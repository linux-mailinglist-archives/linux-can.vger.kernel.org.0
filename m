Return-Path: <linux-can+bounces-2054-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEFD9C879D
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 11:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15199B2F3C1
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133501F943A;
	Thu, 14 Nov 2024 10:11:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14ED1F7566;
	Thu, 14 Nov 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579096; cv=none; b=kDzo3mkMgsfv/aanLEEY8SpU5SwFZM7bcDd6SMvi5JhLU0thM8j0qNEMx/9SSZrf8KefUgA1d3+fV9OQ8AdvUGjvbLs1WvTFaZRjN/oRO7r7EQQn7ZGjSfRXtxTqdEr4IHqG5AGkhNN06nligIj5w2FqV68dBPWZY66FRSJMboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579096; c=relaxed/simple;
	bh=FHPBzkgdhJV+bYh6cr4lkdhdgn6MMB3utmf3P0DVUKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Em7JCu5ESVNKzHQ94iILlnZ0Kho273j/VTb5J5SUSErXlbRkuPXDG19I+8k9UOSZBTkhVm8IEIX/Ktpv3ePxLBHPeGQVdOxvC7F0C4QaM6JfDmSjIDyscRN0bnZ84fgtHd/G0g5+FIUUCiWe/06XaZmfd8GyWP3PJ9M0kyrWO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 3355B102EC3;
	Thu, 14 Nov 2024 10:11:27 +0000 (UTC)
Message-ID: <26302002-0b96-49c1-bee4-648aa18ae7fb@enpas.org>
Date: Thu, 14 Nov 2024 19:11:25 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <22e388b5-37a1-40a6-bb70-4784e29451ed@enpas.org>
 <1f9f5994-8143-43a2-9abf-362eec6a70f7@stanley.mountain>
 <033f74e6-2706-439a-9c02-158df11a3192@stanley.mountain>
From: Max Staudt <max@enpas.org>
In-Reply-To: <033f74e6-2706-439a-9c02-158df11a3192@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 18:29, Dan Carpenter wrote:
> To be honest, I was afraid that someone was going to suggest using on of the
> helper functions that dumps hex.  (I don't remember then names of them so that's
> why I didn't do that).

If you can think of a neat, clearer replacement for sprintf() in this 
case, that'd be nice. I guess I didn't find one at the time when I wrote 
the driver (or I didn't look hard enough).

Suggestions welcome!


Max


