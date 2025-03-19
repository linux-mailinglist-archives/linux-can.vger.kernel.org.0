Return-Path: <linux-can+bounces-3160-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD33A68EA2
	for <lists+linux-can@lfdr.de>; Wed, 19 Mar 2025 15:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895234270B4
	for <lists+linux-can@lfdr.de>; Wed, 19 Mar 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459D192B6D;
	Wed, 19 Mar 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NZZDSOzi"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA16487BE;
	Wed, 19 Mar 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393296; cv=none; b=G8erpKyKPErur40IoCdlRj86H4qj82jOo9HoH4bMSAotR9dWq6J0DLOf3vddeI2yfRpvGtjvlSKFQmPHnVJVrp+jdqi9+LMRGCCNt/6TaT+crp88+2AcPY4Wtedz04CFwb71Y69Fe0tPcilmfMMOEksgbQpVi8EJpsOMZa/Rv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393296; c=relaxed/simple;
	bh=eadsQhCoAnWOW5orH50NaMyqwddlzL1TV3Kc8Ep1sq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+mWJDPzyuzOOqRRjzoF8vbQB0Qi9qFOv7c1AgH2iIQQh4VdPWrx30INFLYe32k71/SaTkNOHOnftsmCbq7YLjLtqwjcN7NFcpi8m6Rk0EwGYMGxwibCDHcmadH2CqjYPbqgZaqPrFRx7PQFGtKTrxsoO3W41ttPy90SGZrgzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NZZDSOzi; arc=none smtp.client-ip=193.252.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id uu4JtWV2Z7cNtuu4NtYw7s; Wed, 19 Mar 2025 15:07:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742393220;
	bh=FXtT3TyOuREop0nAPbjd8Bh8NcKyfaMb6/bV7hE+Y9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NZZDSOziNkt+PTbhmfL9cjo9HFF5lpC4b+Sy0lwu+QyET6zBVpjMJKQiPK5CXPmCg
	 WbtehyqC9u0f4ATJaS2ibG5WlHA+DQumDUlII/LDd0zRQbn+TPIGRYtIDqvzd3/a1p
	 mdrZ9Mgrc2pfHHJ9JTD56wDtJc/hThAcCDIacKoPZ5hDc77KQNK0nmUmDfFInlAB1X
	 eU/JBGCmFzOiCsV/lPdpbCwnQVmWKxjH7bxNOq/Jh8loXekplFe4GKG5FuVk7apo4N
	 cLZP3Aa3YU0MDi53Cc8caUFd5IWl9mG+YJrH89oTAcbC+BRrd+t4e3MzkU+eXXbQWt
	 h4PnE4eqJ0tMA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 19 Mar 2025 15:07:00 +0100
X-ME-IP: 124.33.176.97
Message-ID: <9875d99a-4e16-4f0e-9249-69f0acc4c890@wanadoo.fr>
Date: Wed, 19 Mar 2025 23:06:50 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: can-transceiver: Re-instate "mux-states" property
 presence check
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Peter Rosin <peda@axentia.se>, Aswath Govindraju <a-govindraju@ti.com>
References: <6bcfde63b3a6b25640a56be2e24a357e41f8400f.1742390569.git.geert+renesas@glider.be>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <6bcfde63b3a6b25640a56be2e24a357e41f8400f.1742390569.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For some reasons, I received your message twice (with a two minutes
interval between both messages). These look identical. I am answering
the most recent. :)

On 19/03/2025 at 22:27, Geert Uytterhoeven wrote:
> On the Renesas Gray Hawk Single development board:
> 
>     can-transceiver-phy can-phy0: /can-phy0: failed to get mux-state (0)
> 
> "mux-states" is an optional property for CAN transceivers.  However,
> mux_get() always prints an error message in case of an error, including
> when the property is not present, confusing the user.

Hmmm, I understand why you are doing this patch. But on the long term,
wouldn't it make more sense to have a devm_mux_state_get_optional()? Or
maybe add a property somewhere to inform devm_mux_state_get() that this
is optional?

Regardless, just see this as an open question. I am OK with the approach
of your patch.

> Fix this by re-instating the property presence check.
> 
> This is bascially a revert of commit d02dfd4ceb2e9f34 ("phy:
> can-transceiver: Drop unnecessary "mux-states" property presence
> check"), with two changes:
>   1. Use the proper API for checking whether a property is present,
>   2. Do not print an error message, as the mux core already takes care
>      of that.
> 
> Fixes: d02dfd4ceb2e9f34 ("phy: can-transceiver: Drop unnecessary "mux-states" property presence check")> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Notwithstanding of above comment:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


