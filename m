Return-Path: <linux-can+bounces-4461-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07F7B4328B
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7841416D46E
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F227586B;
	Thu,  4 Sep 2025 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lr2KS+kO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kHdwSRig"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CB27586E;
	Thu,  4 Sep 2025 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967780; cv=pass; b=cnIN00tCcUcPkFNiZ9bLkgYNXUwqrL+8EVbTOSNICOp+XZ0tIDUYbff28UkY4nnHuZbSoB5cyYOCcnfwtL9/ys/SYE+YESd4TMkdStqRfPPKrQodMb93fztsVuWdtt1eXNQBF3Qry4LyJmVILPDSMkHh9oi02wvr3QlrgVqFL4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967780; c=relaxed/simple;
	bh=KWfuWOndEi6XDR/nOG2EFgdxEYeuXl+rJvfeJ5e2TEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNod7oXX36zPXVlGiIGOI9p3MnwLnJAgdQ0v7O0aYfg3U/CyEVdT1wHK7XhEyfcQCLHtUXZVxh+YS+DOq+OZ54hXyk2yYeY3RG5jwn5GZuw3zLBZRx3dilhchEAjHIPpJ1qBCRLQ2ZTlw0GSNh/e0Rp141QQ1v5gnzD2LVTAOS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lr2KS+kO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kHdwSRig; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1756967774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C8QI5EsKrAzo5XU+uSLOXRlfbljCWUBlI0LDmUuFYJUUvU2ZydXY/mV0OaEQLuRZwL
    bJZjfuxcsDc7e3QXn8miwdMOYyGfTsFwbpikd5I3oj+aUffU/s/Ve7abYtAa6hiW0n/o
    1Bn5yX0YGbKtgUHQ9rM02YuQz4qiVVVa3NDuo69RV0qWxsuqr3/KMAZYyTs19U4HluUn
    FS2whBq/dxo5ElyCnLwgMPR/Oleg6zbX7Gzr+9tE9mBky/4mKqFuxjp5SQIy0ISbdAjr
    iMjFQhlOd7v9JnKuquP/5oZ+BCsAwv8GYx6fGyLCY79NTNYRgXtSQWY8EiAzX8AL62Lx
    Rr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756967774;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WNLLBL8ARyJnydp9YLJ9ekRET3L+HhY4TBjwGIKOOSE=;
    b=H95n7BoltTJqbIeY77zMIWi8aKooU3YNLE9cn6Oo30aTf0ftKVGVONFiaW7ofVaB36
    bSKnak2RqgYJ3VUskg2x1EtpyxwhDje52lnJRKzi+2Hty8TDG0iMoy0vTWyrcRYUouB1
    ginv/wZpjeIIdOgp+ZfpKIX2IDoxyVq0vAKWFIfZWPeAIlUBcrNvNTv5Lb3oVTOoDLg7
    /PXe16gzk/7SFG8xqTyW5T+1gQ70E6CgCYmZgImwO82N+PqY4KUcqLy1YSSklC1md/yh
    XuU+aTP1jq+KeckBPY9sOoRoKeS2d8VmXZ8aHO2NY0RJ2NUiLoEqPJP37xUG8LgCeqpF
    le3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756967774;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WNLLBL8ARyJnydp9YLJ9ekRET3L+HhY4TBjwGIKOOSE=;
    b=lr2KS+kOd5oazMYJLd4G24yqyrebWCkOMqH9Kyd8AURrALRIQvMSkyMOPFlssMuOXz
    +BpUd1DsFxQLkLQy1/IKhrGCUV4ZFXtgDOQdchcXa0GDHJdxz0/6hqGvZG7hcUjrjQWX
    glrOtT5FI/U0+nmi6uhbsORSzMzd3XQma/edj41nqGtpToi2kAl7/4GJQnMaMkz8BSnK
    jIGSQ5CWDqO/JdlLPKOYU5WuekEF7V/tFdC2k0p6wkYB54qWsnATOPinJiIpayn3MM2t
    2K7hzO3BKuim1l2RLOaMCKGWNa7gUlLYh9zG0kUD4/XOAmKXPZSb0SiuWKfoiBiQHUke
    A2Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756967774;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WNLLBL8ARyJnydp9YLJ9ekRET3L+HhY4TBjwGIKOOSE=;
    b=kHdwSRigsZPrZxHsLnHpP0cxSTqa7xTYf0e+W7Wz2AHr3C9XCycMhofkELsgdB8QuE
    nD3K/9+HsX37fAluNcCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611846aELiJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Sep 2025 08:36:14 +0200 (CEST)
Message-ID: <e37c9890-823f-4a38-bdcc-c170dbe67e13@hartkopp.net>
Date: Thu, 4 Sep 2025 08:36:13 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] can: netlink: preparation before introduction of
 CAN XL step 2/2
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
 <6e4dcab9-d3d7-4c8b-99c1-f472bb7caa07@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <6e4dcab9-d3d7-4c8b-99c1-f472bb7caa07@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03.09.25 11:26, Vincent Mailhol wrote:
> On 03/09/2025 à 17:49, Vincent Mailhol wrote:
> 
> (...)
> 
>> The follow up series which introduces CAN XL is nearly completed but
>> will be sent only once this one is approved: one thing at a time, I do
>> not want to overwhelm people (including myself).
> 
> If you want a preview of the full CAN XL, you can have a look at my work in
> progress here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/
> log/?h=b4/canxl-netlink
> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/log/?h=canxl-netlink
> 
> The kernel part is nearly completed, but I am still playing some whack-a-mole to
> find potential gaps in the configuration validation. I also need to rewrite or
> fine tune the commit description.
> 
> The iproute2 part is still under development. It has the PWM interface but I
> have not added all the control modes yet.
> 

Thanks Vincent!

The repos are very helpful.

With "missing" control modes you refer to CAN_CTRLMODE_XL_ERR_SIGNAL, 
CAN_CTRLMODE_XL_RRS and CAN_CTRLMODE_RESTRICTED, right?

Best regards,
Oliver

> Regardless, the two links above are just an FYI. Beware that there will be some
> random force pushes without any notice. You can play with it but it is
> *not* opened for comments until the preparation series is approved.
> 
> Looking forward for your comments on this CAN XL preparation series, it took me
> a fair amount of effort :)
> 
> 
> Yours sincerely,
> Vincent Mailhol


