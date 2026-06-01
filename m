Return-Path: <linux-can+bounces-7733-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FkwHfHPHWqjewkAu9opvQ
	(envelope-from <linux-can+bounces-7733-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 01 Jun 2026 20:31:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E789F624020
	for <lists+linux-can@lfdr.de>; Mon, 01 Jun 2026 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 345C030082B8
	for <lists+linux-can@lfdr.de>; Mon,  1 Jun 2026 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3513DD857;
	Mon,  1 Jun 2026 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JNRGJVtu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qWjL+qgd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960E2C0F91
	for <linux-can@vger.kernel.org>; Mon,  1 Jun 2026 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338359; cv=pass; b=H//b+ziqI3lvy35GZVAxSXibvJwCeAbBtwv4zBldYTDeuAqogrpVeWF/z15FwyOwsv1S8QrtSyoPrCyuFSM9OYfQv4H0mWFDK0xObv2DTp94AQSNymr++0dz95SXOg+TrCQvixHYgGWw7+oiTPCgOwyxi/MtIFbxeycwGcEo8QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338359; c=relaxed/simple;
	bh=cCKuK3KIAdEfRiCMI65YrOH3ktOZvq/lAmhsh7l+Ecg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aGAMMr4uU1WOk4YwR0fLIEkCXgGxvJP5L3hp3xlwePOn6RokjbJBd1tZnNZVKN3x4Pn+tPzjNygxvZZk0oBXiP96dmjnzjZ1wCSH8lfNk30uzr/2GtZCJ7oOcDmcV/Nu8YSiOGgcUNDgcr08P6EH4IUyeN7JhkwB6Smp25a8IkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JNRGJVtu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qWjL+qgd; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1780338166; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r/8AVdJ7PZi7djwlJJ4FxBJMjGR31ccontlKyAsqr5oMliz/PSsWbB9PEYl5YyudiF
    L1ewlxIT/f5VEIy2B7GVZHkgI9IzHcP7qNmBVzHsKkS5dk5fmRy6TRtFaHHv1C04Fm40
    XzTHCrwnUVIFjDKJGpwE57qLbS3gUXQUNoMmWQQcV4dIwX6OA1O0vhJ48Adnt7lwvnXs
    VkyGFegfgN/Bh2XkCcn7aJGkR7LUiyKrA0iA1JrNUZNpw5H2FgNRMWlIVI/5YZyPaTQ+
    5mYoiJH2jdq8qgM9S+v0ZckqnUnmb1eIH6OpVoKDxK5KMniYvlibWUzN+W6cobi1JSoX
    cqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780338166;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=O9ozLe97cWCfPqzmrYLqV2EvdcKAc2Z8G3qFmL2PyVg=;
    b=n7sSUi3LqC5KObyzdy1WkDpBqa0jNP/Wp6XmBA5ZjtwkPset8fF2eqbN1k7KZhokJr
    +b1AEVH7iGKS8yCavgjf6SSNlZ+SS/50SMpW5BYk4hCMSJHE1aMwf0tiBYlQhEg6KM0n
    Rx/eds3D3wyVtXk6KRUe4VLapvEbO7w7pg0Yqw/6Javf0dr2PSsX+dXC2AHOK4japZOt
    bCB2jgdTIGDb/mTFMixosDbWq/q/o4opAfjeFH+vcenjnMJveZGaBki3xLWDlria+mfI
    15fh0LhKHQHqOoaCrnKi7D5zVEU8lB8z5hsLDFE7iENp99grnLcivWyzxuCAx/po7xsn
    U21Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780338166;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=O9ozLe97cWCfPqzmrYLqV2EvdcKAc2Z8G3qFmL2PyVg=;
    b=JNRGJVtumFkLY+w1Pa6z94iyJhpPq4PIafrdRkGLUPvLAH7PYNY9RytK5Xpah1we1b
    U8hvZdd5W+U7HRNCRs1X0+4ZwjdiXTIn9xp64ri8eSDSTX192KoVaxHt/m3pQCDs2rVK
    s7Bd/ZWVUT2D/g2apDN5e7DD+3yeaxjXIOoBlEC5bJjG4e6t/5YP8hJWHrJwM9q4M2HW
    9n8toEtgekKOCdSuTnp4DasIbSGEN8DTOQArUhh1f52GjyVDs2+BLbnyfBW0XTRTfWdw
    sWmxy6ccenP4Sq2utw9P4oQPwsHPkavnXmzaT47g1nvqhComTmqHHAhZNJg/IP3v4jFX
    EBlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780338166;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=O9ozLe97cWCfPqzmrYLqV2EvdcKAc2Z8G3qFmL2PyVg=;
    b=qWjL+qgdr3beW1rLNFSm+ZMPcO719/ryyHTtBeUIA6tI04xFVc7zqmpqtvIz0kmFLk
    suvBTahlk+/OVUfGZ1BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d251IMkEPy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 1 Jun 2026 20:22:46 +0200 (CEST)
Message-ID: <491585e3-6f9e-4ff5-b788-1c7b8d238a48@hartkopp.net>
Date: Mon, 1 Jun 2026 20:22:41 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Potential atomicity bug in net/can/bcm.c, between
 bcm_notify() and bcm_sendmsg()
To: Ginger <ginger.jzllee@gmail.com>, linux-can@vger.kernel.org
References: <CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7733-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: E789F624020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Ginger,

I created a patch and a commit message why it is not problematic due to 
other restrictions with so->bound and so->ifindex in bcm_sendmsg().

https://lore.kernel.org/linux-can/20260601181915.71862-1-socketcan@hartkopp.net/T/#u

Many thanks for the report and best regards,
Oliver

On 01.06.26 11:28, Ginger wrote:
> Dear Linux kernel maintainers,
> 
> My research-based static analyzer found a potential atomicity bug
> within the 'net/can/' subsystem, more specifically, in
> 'net/can/bcm.c', where bcm_sendmsg() reads bo->bound
> without holding the socket lock (lock_sock).
> 
> This potential issue is present as of git commit
> eb3f4b7426cfd2b79d65b7d37155480b32259a11 of the mainline kernel.
> 
> bcm_sendmsg() checks bo->bound to decide whether the
> socket is connected before proceeding:
> 
>      if (!bo->bound)
>          return -ENOTCONN;
>      ...
>      lock_sock(sk);
> 
> Meanwhile, bcm_notify() clears bo->bound under lock_sock:
> 
>      lock_sock(sk);
>      ...
>      bo->bound   = 0;
>      bo->ifindex = 0;
>      ...
>      release_sock(sk);
> 
> This race could potentially cause 'bcm_sendmsg' to operate with stale or
> invalid states.
> 
> Best regards,
> Ginger
> 


