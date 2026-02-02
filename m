Return-Path: <linux-can+bounces-6458-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBDwJiIKgWkCDwMAu9opvQ
	(envelope-from <linux-can+bounces-6458-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 21:33:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B5D11E8
	for <lists+linux-can@lfdr.de>; Mon, 02 Feb 2026 21:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1E883020FFE
	for <lists+linux-can@lfdr.de>; Mon,  2 Feb 2026 20:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6CA2C08AB;
	Mon,  2 Feb 2026 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBbfZ/nP"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4142BE026
	for <linux-can@vger.kernel.org>; Mon,  2 Feb 2026 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064401; cv=pass; b=B7IMG8YE67Boe1D/Jrtr3H4XSltkqqeiqfsVWufv7odfl6vUC5GmfEuDWvKoQ5FdezMiQT20hCWmLwDty6tYbsYnDUH2yRN0F30mhuRKaNOR6e98LnlAFnsOja+Mjrnxkl3F81+Gaogc+Ah15gf7NlRXC8Q7sdejk8RkwaEORNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064401; c=relaxed/simple;
	bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wesl659FdGe6Oq1DHWg7NVPSbuaJ0NyGOpbNT1yenPf9tBNMcWZzEk2dlBQsgA/7GhrgfTldCG1jhbpN5OlFbY20I0norZnkbQFMlaHVmr0B2e2StbK84Zb2aMqNVD3D4jWOGTDINlvuRxUKMDabvot3O3UbG2nkXgPRuUfKKYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBbfZ/nP; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso2023966d6.0
        for <linux-can@vger.kernel.org>; Mon, 02 Feb 2026 12:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064399; cv=none;
        d=google.com; s=arc-20240605;
        b=Ef6PqgZlLOXrcYGA0g7mzZIiQ0VdChT/zCbv5dB93U5fVZIOoleg+qQ9W0YEbexR7W
         jMqNNCc76pRuXcy4t6shmFvWve+QMO5//uvP2XNGuRYvuuJ3pA8DF+upUO3PDoAswEMD
         VVajTkdQdp11HBHskFAiEBoNHXL+jD42uglDS56ShjsK42tSgQImfV1JsE0Dux95wdut
         8Q0ofyt3cGUo+4VVaOAjiBguX0AXOUXz7fM2Xyxf5+0Tj1hMkxaQH48fkbkMuyFaZ+q0
         E64ByE1/wXhlroacby1ESMEJXJkMDRO0hyatZBZSRJKdeR6HUJX4W0ZZHZPay5wyCw/+
         DDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        fh=T8CsVADsrJnr9wedbWyLoTe2eTX/tQ//2UBy/1vSOuA=;
        b=JQJtl4+Ule6fIB1NcfPw7Dd7i7bp2MT5j09O9zOqBPKKa+jqhhBzC/6AXKCGUDdWJu
         Vcun7hUwMUuVK+sPUjBpIqIa62x9NtpHeUyQpOfhtjp5vMkSAnDnABuUJVq1VXl6lfXG
         tMh+/D1vUbu2H3DKC5JuhqmcABLkdETwutLnEGjE741dHAA1bRK2galQaQJV/T1hJi+B
         PQssJ4JsfjyvKibgxgHWtVJYiy17txA3LOmk3OSfAMD0MbAMir1O0jnXTBNVb1jvrG51
         fCIsobs5YuZGRBBy0CSDA2moXQMREam/oL4IuP3aySyPErwoANFE6e7YIY3SpgeXTLk4
         CytQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770064399; x=1770669199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        b=iBbfZ/nPM727rAHUVpxDEmU9ximHbZm2PZsukq+QQ6ysWqaAcE+pX4uF7bALK1g2+H
         6oVaWZ3ajgONPypjpjYReHAlmos1IS6C0OzzOqDrHPIilISJtcwMJbx/rmY9QU1o7OmN
         UXf0vh8pYTN56PWZSFiz4Jf09CzEShZ1jTeeP1MM3wZyNjdzuYpO6EinNFMXdmVeqotd
         jNpbm0GYZf9zOpkm5+y7w1hjr8DveNOGkgi1r8AsUNgR5QPOywyBZ8XRUO0j1AspDxc6
         CMwYQMAgfWAqPzblGt1LhOJ1bcjn/fWMIYp/cEnVDoZ3mDL2k1tNZP0ayDoYcBUPuL+j
         SlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064399; x=1770669199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        b=ax42fPzpDSknOJn6jn7b3kh7XRpDfz9jv7PuSY/HxPY+lFDXotHHMVIqGDXo11I9rt
         qYA0msPaV/OLbtLSrk/7LGUmoJ0TIAKwPRzzfyWKpC47Ns5FffkvuGbcOq9rTOmP0tEY
         7H+zFGY+rxiNIqKeosM97UkisLMztUmtic6uT44MUdPQ6FthBku6SHZqxpKUeu7utszP
         0ilHonmSRmlOPiYDLVDscWCjrsumWSDS/7sxGs76ua5a8wRgY2OZkrVJyswcYcofJsMg
         TLvBbtPXiHtkRZlA6cKHA8PuSTRp7VLLGcVh1gpN6GRbuC9Wf50thCPP7sKysCADwO/0
         j7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCV2cOQhOmxuiLTccEMEbRIkeTvn6Z5hRjyRGg0bmJfaBgJjnb0N2cVwYtTxaX9nNnv0OYdFpEEKk4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTWKbBvLFTP+ZFUKm7GyD8dhZZ/M5ZZhjBrcyqdZD+fgHoteRf
	GszuD/YDIfSR09soXBmQcBxRx7zSm1CdZGQeETO5IMhF2yT48098wsQpB8MFVxY9iJJv3al0vwr
	rRfLT1D3qmsjN/PN8/TMPRZROc3/Py2c=
X-Gm-Gg: AZuq6aLh2JI9bnNjhQa2I8/TAVmX4dBB2/+KRTR0y7AQZa1p86N0V6A1TaPpdVOLUfV
	STxhU1AJy9o5uqPH7v5TIjqP26gBK8jUoBnI5+RVuhjUrDx9zCfpi2ZABYYY51bSTPARtziR/u2
	rvGOZiVCTNHNWz3JpUlZ0EVlMDr0GrtsHTxzmnlGjkxb8Y/VZJJWfREzvv9rMfNdmVeCjGePHIj
	plid65VxBbchgclP3RBaLOzxODhuPiTOvjAlBsokfIL96tw2ECyyc3hpkPtom6g1pJi4IDz8YAi
	S7Cnx4Ev/Yt2uKG+4owpBMJI1oRTgRPCyeaNcW1hQchWaOwJ6dhk0A0/pouRh1QVP+zrnLXTZPM
	Yr/Mp1JHs9SMlxw==
X-Received: by 2002:a05:6214:29ec:b0:890:2504:5450 with SMTP id
 6a1803df08f44-89518339570mr10555056d6.19.1770064399203; Mon, 02 Feb 2026
 12:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131004327.18112-1-enelsonmoore@gmail.com> <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch>
In-Reply-To: <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 12:33:08 -0800
X-Gm-Features: AZwV_Qg0cHrJ5V_p9yHhT8vkb6bWLIPXh8gwyXrWFaYVQlzEDDO-IwvtsniZn54
Message-ID: <CADkSEUjEYY=Wwyumv3Ft_T=xWLJY2hiy4uw_YMus=4o=61H+BQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wireless@vger.kernel.org, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ping-Ke Shih <pkshih@realtek.com>, =?UTF-8?Q?Thomas_M=C3=BChlbacher?= <tmuehlbacher@posteo.net>, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6458-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 521B5D11E8
X-Rspamd-Action: no action

Hi, Andrew,

On Mon, Feb 2, 2026 at 12:29=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> I could be missing it, but which module does not have an module_exit
> function?
None of them. That sentence was just to explain why other instances of
empty module_exit functions were not removed, in case someone else
tries to do that. I didn't realize module_exit was required to unload
the module at first, and other people might not either.

Ethan

