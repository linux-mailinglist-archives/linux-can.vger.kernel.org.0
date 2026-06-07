Return-Path: <linux-can+bounces-7762-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZXAGOYsuJWoSEQIAu9opvQ
	(envelope-from <linux-can+bounces-7762-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 07 Jun 2026 10:40:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F864F25E
	for <lists+linux-can@lfdr.de>; Sun, 07 Jun 2026 10:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pmejJxmj;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7762-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7762-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FB3E3002E69
	for <lists+linux-can@lfdr.de>; Sun,  7 Jun 2026 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BC8302753;
	Sun,  7 Jun 2026 08:40:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2F7404E
	for <linux-can@vger.kernel.org>; Sun,  7 Jun 2026 08:40:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780821635; cv=none; b=Dbr5gBKZ2Wqnmq6ADrDbKysdeSTMEXBYqFK7RQPpVRfbXEAfcTLM/D9pmolyRm7/CdhLAa/HPYv4BeKyNpdHbuDDq2uOohn9a3t31to1XHBVb+6BWrR0LQQZi9k+IWCBG2DAuLsNDdyK3Iu1hLurJn7oSlSB1cXAS16IwdBQwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780821635; c=relaxed/simple;
	bh=z4rfpECDUd4+fp5V8mPcIWgEOMMN5fJNP5S4vnw9JZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlzId6iCntu0IFCKky7AUMe845mxzOAhm/RHcC3gRAeeH++TlG0y7uk+7p1BktTRWh5zuq06gCDTgfXL1C2bAr6Pn3mQXToqA2xKQSatlultxFGJ1++HLFrNb9xOE47nY7nn3kg3NGz36cAXFkUYlMqkOoigyw5hs3Q+LE7ANJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmejJxmj; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46019edc13dso1483349f8f.1
        for <linux-can@vger.kernel.org>; Sun, 07 Jun 2026 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780821632; x=1781426432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw1xVuhJOQHbfyU6Yw8EFKK1j/gn1/vNa/UVGcPSkm0=;
        b=pmejJxmjJQVSWjPE32PPEmG9rBGizJfyA7rkEx+krkJnmAEfuCfGKZR2+Iwrx/K7z8
         fs7XNrZL+QVL0rGQ70IpR/rH5/dFFth3mTf5C7J2kPGxsYc8AIJ+0PX+USVJIVcF9XYz
         LhACWI+SQIOSgqndAMsy6RJSs8rc7MfOnONJt33b9eubWRUMa6er40QOpq5Q9URtzRjD
         NZYjfxWMoIcI9utncep3/EC55vTjYfSRB/D5rfolOw0W7WhyjydH2AqWy5lcU2sIaQ3s
         afpVThSoLAplzbZQRSDQmVSzYlXkCPHSNVSZZuGhCydGGiAalUO/Xckvdlc+uqqVJOxt
         Rdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780821632; x=1781426432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vw1xVuhJOQHbfyU6Yw8EFKK1j/gn1/vNa/UVGcPSkm0=;
        b=fu0iDZX6ggjRb+adgfdiGjSH3Ck+THXACKhIGIbOCh8eSODBdPdTLwEW+VxYvajN5D
         Sb8BPh4XGdSGdJRZQK2KxfdJvGp7R/JIFapprGpFIcFKZIGWsBLMl5IUM986YhSpaPmJ
         UPO64877M92veJyfFbM1EvBWvIvP9R+agBSJ5iTeu79psSk7pAKDbO+jPJ3+WArlZC9p
         Ne7b8RcZcWAg7QM+3L1ls55L/Jw7NPSavEXyJ0+ZiXFSp1BQVlGy3LHWjTRM7j5gD5u3
         plPLbA8CpaPDAuAJCR5diPwBV0wXecaVTxoSdNzEVMhkxmTqPyZ8r0Dd3WLOr6WrZ3OD
         5rlw==
X-Forwarded-Encrypted: i=1; AFNElJ86LhYDMEfXeEDckAO4DWe8XCQHL4l7M5s9RmfTa0A+u1jGU9UTEAMGLwPRHdcIzwYFdusixnKLZ6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTwvRNkA4QCC4yS3P+RFxqhYN2AImtrlD9NPkjjuHP9c20wTs
	rWC4wMA8Jn/S8rkAz5G+6pcXBxIz6ZpRiTP/uqxrifvE5F9lL7fanIrrZ/Tctx80
X-Gm-Gg: Acq92OGRPwNVA+533roTOpyYhCavm8FaZTAjxXXJjILgfajpi/F8IyUoMLMZ336o9Kt
	32ER4+M03hFa9IM3BxrSxYjJxZutzyZHqaR3Un0KwQEUjVIdIP5WHXklU2KlvdQApqVo9ghtn+j
	JJgOc2MLvYhI2EvOZg4sXXrurS1WB/0YxS+kTn8FzMjj7gNF/w7XuwpACwLKMoaY4EQEz/OrJro
	HBvc5yEiP6/HlB6HVhbS8BJwOWEEcXdz5GSRkHmZRcYQkoVx8u0akLOLJJNSMDIV5vtAlS8rzPc
	pndScyxJw4V8n/sP/UDDAHFIu1ZctCndIT8cdKuODvnaJE3YWBghPA3GWwu8wyPtlnwFf8BTuSd
	iCfhlEopLM3REG/SDyJIU/L2aF57lJYgQfp/FoFqrDapRUBrttyTqvF/NnJ2NB0i7n5tLwaNTtP
	5zImopRk/JWUPHxvpdN0q4du5tKVLKpRh3gq8QNUl6NqABLyzNC8BtGBh8mlY9CJefShfZCgsxa
	LqyEPFDyQ==
X-Received: by 2002:adf:f911:0:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-460307625cbmr11917197f8f.34.1780821631657;
        Sun, 07 Jun 2026 01:40:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2eadefsm42644235f8f.11.2026.06.07.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:40:31 -0700 (PDT)
Date: Sun, 7 Jun 2026 09:40:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] drivers/net/can/usb/kvaser_usb: User strscpy()
 to copy device name
Message-ID: <20260607094029.6ffd4eb0@pumpkin>
In-Reply-To: <f8848570-8793-4f5f-a2a4-ab212dcaebcd@kernel.org>
References: <20260606202633.5018-15-david.laight.linux@gmail.com>
	<f8848570-8793-4f5f-a2a4-ab212dcaebcd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7762-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mailhol@kernel.org,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D8F864F25E

On Sat, 6 Jun 2026 23:16:47 +0200
Vincent Mailhol <mailhol@kernel.org> wrote:

> Subject [PATCH net-next] drivers/net/can/usb/kvaser_usb: User strscpy() to copy device name
>                                                          ^^^^
> Use?

I'd forgotten I needed to fix that typo before sending the emails.
git makes it hard to change the commit text itself.

> 
> On 06/06/2026 at 22:26, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> > 
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> > 
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> > 
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> > 
> > Note that all the changes are only compile tested.
> > 
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> > 
> > All the patches are being sent individually to avoid very long cc lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)  
> 
> Indeed, this is terse. The commit body is empty (all your comments are
> below the --- cutter) and the subject line contains a typo.
> 
> I don't see why the fact that you are sending many fixes clears you
> from writing a proper commit message. And I would expect at least a
> small effort to customize the message: only explain the Makefile stuff
> for the patches which are touching a Makefile.

Try it!
I changed about 150 files to get allmodconfig to build.
I only send patches for 45 of them (otherwise I hit a 500 email/day limit).
The next 45 are 'pending' and some of the uncommited changes are less trivial.
Spend 10 minutes sorting out each commit message and it is another 16 hours.

A few (like this one) are very terse - then I realised I can send slightly
longer commit messages by typing a multi-line argument to -m.

-- David

> 
> >  drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > index e09d663e362f..2cd58e825e0e 100644
> > --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> > @@ -746,7 +746,7 @@ static int kvaser_usb_hydra_map_channel(struct kvaser_usb *dev, u16 transid,
> >  	if (!cmd)
> >  		return -ENOMEM;
> >  
> > -	strcpy(cmd->map_ch_req.name, name);
> > +	strscpy(cmd->map_ch_req.name, name);
> >  	cmd->header.cmd_no = CMD_MAP_CHANNEL_REQ;
> >  	kvaser_usb_hydra_set_cmd_dest_he
> >  				(cmd, KVASER_USB_HYDRA_HE_ADDRESS_ROUTER);  
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 


