Return-Path: <linux-can+bounces-4447-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D2B419E9
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 11:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC691BA3760
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D52877C2;
	Wed,  3 Sep 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm/kZVDI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D50E552;
	Wed,  3 Sep 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891622; cv=none; b=WhXoegmxQ4P34lV8XbrayJGkAo6Wlr1SxCEskUzylNJHDNCdMhezsTcRmaUaTKHNdZ94PKLFKPkPE6sitXjGI/C2GFWuw/a4FVJEwZNqqBkzRWqKtnc0EgT6znBXK4OgYTvVa4JtC6I26iLBceAStfD2eS27hX8Bf6NIFomOEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891622; c=relaxed/simple;
	bh=jsAVCFDPQiOFXQdLKLJ0b6ZuvBazzsZ9wja7azPBYUg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hrvCT8/tgpsG9wjr69iYMamVwj3jOOKyWQywxlsDmW2X7fnPUXQzx1hcUV0VFH/QAVBHCfu4TmaLna5PYKsFiX/7FLK1V8FhBjP1qVvWOfzB44OawKucKTXpah0fsUxRpWn6qTqCMN6itZPsP5eWhvKT72yg5LdSiXDfgvCjfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm/kZVDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6DDC4CEF0;
	Wed,  3 Sep 2025 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756891621;
	bh=jsAVCFDPQiOFXQdLKLJ0b6ZuvBazzsZ9wja7azPBYUg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Rm/kZVDIm43Wmmq/h2Wnwfa90hdFC8eLLLENR0qRZohabn2LUkA2Jn3LggXeZkbGa
	 YS43TKeg0UIwRyf7HX38RmHcU7Yisu+EknpuYKQz+I0EfHAqshUwMd91etsLJ5qFGD
	 xIe75uFP7TV29fOSOXqNztluRIWrGW+K5ZZZUTMPl8+TpX/GnuFo22jx4CrMpeNk7r
	 XG+QVXCJCdJfWrXEIiR6ZmYoYbmphk5X0Ey3kmaJ3JUF4ZNN6ZnUS87nJ+UKyTNPY4
	 dTR8EjththvFC+B5OGqlJmXMj04JnPdvR9aYSzZ7FPMlPVyX+QxSoKjVmqkc0iIT9Z
	 q4AE3JpSb9nOA==
Message-ID: <6e4dcab9-d3d7-4c8b-99c1-f472bb7caa07@kernel.org>
Date: Wed, 3 Sep 2025 18:26:59 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH 00/21] can: netlink: preparation before introduction of
 CAN XL step 2/2
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2025 à 17:49, Vincent Mailhol wrote:

(...)

> The follow up series which introduces CAN XL is nearly completed but
> will be sent only once this one is approved: one thing at a time, I do
> not want to overwhelm people (including myself).

If you want a preview of the full CAN XL, you can have a look at my work in
progress here:

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/
log/?h=b4/canxl-netlink
https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/log/?h=canxl-netlink

The kernel part is nearly completed, but I am still playing some whack-a-mole to
find potential gaps in the configuration validation. I also need to rewrite or
fine tune the commit description.

The iproute2 part is still under development. It has the PWM interface but I
have not added all the control modes yet.

Regardless, the two links above are just an FYI. Beware that there will be some
random force pushes without any notice. You can play with it but it is
*not* opened for comments until the preparation series is approved.

Looking forward for your comments on this CAN XL preparation series, it took me
a fair amount of effort :)


Yours sincerely,
Vincent Mailhol

