Return-Path: <linux-can+bounces-7761-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4V3WF0iOJGoT8wEAu9opvQ
	(envelope-from <linux-can+bounces-7761-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 06 Jun 2026 23:16:56 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEDD64E638
	for <lists+linux-can@lfdr.de>; Sat, 06 Jun 2026 23:16:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FCXB/xM8";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7761-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7761-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69DFB30071E7
	for <lists+linux-can@lfdr.de>; Sat,  6 Jun 2026 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC9314B62;
	Sat,  6 Jun 2026 21:16:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD704071E4;
	Sat,  6 Jun 2026 21:16:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780780612; cv=none; b=OIormdUqgDKL6WBPtfZNYtoBX/C/gRoQHgQEg6onIcbZgiP7g0DWPRDdG3mVjNPQ/cFoNGAohogueuSAiTe5tGGj62WTAQpaXH/qa5IsIeypYuMto1ohylB+chrQEI+fOgADDAMftbwwyyTTII3CacfNo8DUWXGzm27rLGxXPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780780612; c=relaxed/simple;
	bh=VID5ekI296zxiGIC/MVdrPWsADdvn+rHypBqIyDAdBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVtsuX9dx86gWModV7WVRCV5Bsk/A4Gg72wa8ZbLVYLMu1PEkwOCy7JV9EOZ9SW5c10cZSIGk3osPUcBp3qFnrwVo69XgD+jdSjLDDpPy1JmC8eMOJeMa+zlGHF+ZiHaY8tWiZ+nFkF5LAk4I63k2+EtxCxdfFgm9omssRPYNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCXB/xM8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E530E1F00893;
	Sat,  6 Jun 2026 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780780611;
	bh=RUSqkmy+o6mOZHEkCNUgqgA/PKBCd1l9wehkyDHFxYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FCXB/xM8gLRq/ahMdTqGZ0Rgze4rK4KyWpz4lS4/8XETBywpMDnazxH2ZNqasuOzn
	 m0CDtN5+RKBcKyEC/eqFRTDrJnTpA42J6OdEHKsXOGpOtlRtR0sJ5KaUanbwTX+ewV
	 0IvCu8USejv/OW//ZO3EhZoAvPIlKIkYxAUp/qjJP+B9Yf7J1xbga0SpF8NonDXj2Y
	 GpB5drVfe/zBz+EyHYtLW8gq9hmWkQr3Pmcq42zsnadyOOFZtkU5NJgbqKtAqoTk7C
	 wXJovAUVP5ZGluiTYC75bOT3p/5unyrGHDt+u/H9YPwYnzvpWYBVVfZ6mzUyHfm2A0
	 1DDl56PX95kow==
Message-ID: <f8848570-8793-4f5f-a2a4-ab212dcaebcd@kernel.org>
Date: Sat, 6 Jun 2026 23:16:47 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] drivers/net/can/usb/kvaser_usb: User strscpy()
 to copy device name
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260606202633.5018-15-david.laight.linux@gmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
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
In-Reply-To: <20260606202633.5018-15-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7761-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mkl@pengutronix.de,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDEDD64E638

Subject [PATCH net-next] drivers/net/can/usb/kvaser_usb: User strscpy() to copy device name
                                                         ^^^^
Use?

On 06/06/2026 at 22:26, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)

Indeed, this is terse. The commit body is empty (all your comments are
below the --- cutter) and the subject line contains a typo.

I don't see why the fact that you are sending many fixes clears you
from writing a proper commit message. And I would expect at least a
small effort to customize the message: only explain the Makefile stuff
for the patches which are touching a Makefile.

>  drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index e09d663e362f..2cd58e825e0e 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -746,7 +746,7 @@ static int kvaser_usb_hydra_map_channel(struct kvaser_usb *dev, u16 transid,
>  	if (!cmd)
>  		return -ENOMEM;
>  
> -	strcpy(cmd->map_ch_req.name, name);
> +	strscpy(cmd->map_ch_req.name, name);
>  	cmd->header.cmd_no = CMD_MAP_CHANNEL_REQ;
>  	kvaser_usb_hydra_set_cmd_dest_he
>  				(cmd, KVASER_USB_HYDRA_HE_ADDRESS_ROUTER);


Yours sincerely,
Vincent Mailhol


