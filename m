Return-Path: <linux-can+bounces-6460-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGJvNAxIgWkZFQMAu9opvQ
	(envelope-from <linux-can+bounces-6460-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 01:57:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E13D32D7
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 01:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E5C300BDBF
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 00:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5821E25F9;
	Tue,  3 Feb 2026 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agj0LUKv"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525B1F5834
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080231; cv=pass; b=I7thfq/WQ9Wf118YdMcufklVpLpXctJvgKEpQAI0OyBJhGK3wHFsSFW3YksEwArPaS7TBRODy5KsD1vsmD9F//5xnNtMYboccr3PJrEIPfmPFgs5T6RWHfoiJq8ytFmAZRYIHb7nQrWz6VCRu5T+Qs9i9lZD52TOZw2y8MWqHXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080231; c=relaxed/simple;
	bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaThbG/HCZeXTFG/xqE5+bJFLOWsB5aPNWDA3TBSjSgqxbPYnK4XwGZWBx64i9Bm1adRUSYMaPQOAh/VfJOjUE9aTrgSmt4w70alHHy1I+SwlchelGrqWd6fNRAuJfI2L+hWQSWDfcpy4bydsrQiZkk3EbXE4tP60RY2SwlyxVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agj0LUKv; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8946e32e534so59428206d6.3
        for <linux-can@vger.kernel.org>; Mon, 02 Feb 2026 16:57:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770080229; cv=none;
        d=google.com; s=arc-20240605;
        b=M1iAAlDfE33npiSGwri+C9/ouRRSXdxqig2VzewY8CwlqObB9IxfMAsTpkx5A4Ywk3
         cCMpSgJhNARO+a7NZLCnfluckV4iWiXuLuB5arpkfkJH49/425nvwP2QuJAJb7S8H5kK
         935hhJGEAJ5u58ubROdRtrYwsD7bUqRvJsi7AUKsF4/voaENVEhVU3A+NJ4TzfiUJ44F
         jCYvBhIyCeE20us6f4ELFOHUodd57rM2jrjD6DAlGtnbemH0W5fo98k86dPXjppcCswr
         oOUIakS9nQeXQebdQcr4wvSkaOFK8Q42Zy2OkX8XLR4A4AXJWZCgrFWimR9eKhwKKYCX
         iQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        fh=TObp6Fc9MDRjqouoNjZtF8MUG5mUdEavMwe5rrJm77U=;
        b=GTSUzS/KFA17WJE9OEq208e9KuCyeh3wSjeR6pT/On3q8Kg5QjR3/iYZfLYxt5E4bi
         6hm8g+0BurnIa678tehf/WnvXot0pHvPJOt9IA6vXHm0BRaxFBYzrOroWQFnExXljo1G
         buNDwmVuhUQ434y9vEVPAIUoRJgj6HfElXh6l6GRYgMkY03HN/C4JSDXmhHuOtffGotK
         rWQQyARd4uOjgKnnD0Cym2TTuj6QsDz/RPYiBgZDhTyMWmyFmjjQTWr/i1GbgKx83HQt
         SUVznUl5vLwSHhX3jyG/oLrBGKNHMVvquKh1C6G1iR6y6yoyjOb22g8udi+lHzK8+Jty
         1yVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770080229; x=1770685029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        b=agj0LUKvCNI+z9z47/5kTXHAVgRBy4EBnVUo95soHvJsQMsvTgnU4DKES7IJqm3/sw
         7+U4fD1Npb3IgadzPdCy9mM99lWFUp2Z9WiNOLH3Bb5154PEM9VXvwYMKXVxSsZeWSwB
         zUHrTfFRC/Z97GFPkg5VOfb9msE+VA8Tj5g7baY7JbTO14FkSEiNFZrkdT9mDDB5kE2N
         AM6eQsrKif65TcKPq7/YbLfhjzp3IoqE780unlCpSj2kbxrfXSjBUvXDZwvEIt9FSDOF
         R1SrBVR+yp1iE/YCw3Xalw3EhAFWdXlwLvs45OG71tNHdy8c/BUR9b6oFpZxVCj9RhZj
         pn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770080229; x=1770685029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        b=kZsSeFRFLTWFVik8TMSI5po4fvmWrvxpXqSsIjG0yC61sw4AZKsc9tbg0UsWY0jTRu
         xKo7HluFFuZrTNqQ6ho/T2+DyDas3UdR2aTXoQCfWq/WJLoAH0bLMw6YIuJ0houacOST
         DaZYvm3olHnH2Kw7RibGJY490qa5rBj933rPUAdyuOS6Au8kb969oGQ4hMat5IiVyXEK
         5WFnaSMA35SQb2mWmVszrC9Zl21kdtcQC/wnKiXEmb2LkrHgg65mTnLrezxCVPIiobfw
         8JGgiTHxhtC6+C/Jg1NnEP/501JCzDRcjtTtAXgTxCctf297zXzc30t6odyKve/EHNpx
         UV+A==
X-Forwarded-Encrypted: i=1; AJvYcCWr5qYAkKlbWEVHrRWQJylyUeMbHmsFYs5jw9s5SI9LmKhUJXVtNXEzzq8Y918N2cUteOdI3OgtVn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH422q0s5PNS5LQTJvDbPlUTjlwGzbZPmOrokvPw4GDTwbYb6G
	Elpnh5Ffi233vNmt/J+sAA/WsOhiR2l8+YBQBEwYG2SerGZ0pdSWqCrCWWqqNULmbfjfg0ckK0X
	tg2/oK62Cj8v8rVZflqVn51wb9pR74oA=
X-Gm-Gg: AZuq6aIaPFt86/3wVh+VaSl2nYvSLjlRk004XZMNuN/mLvmjUgnm322ms5M8o6PyPRg
	bN7cfi15stc+AsXR9yfu2AR2jYasfj4mfXr0PD3AEa1tUd3TNSI/UBAxUbwdmYAKO41r7Kg3nI6
	1WF6pSYd/xqWIij4RPGKyQZ03TSMIYCnxt2nWPp5DhGC64jFsfnaq1/ZAC+p0RSiwBaCcuji1G2
	tY1hr8p4Q5E1LaqDsk1xAomKwWQiSCr+Sp7+yGL5D09ne/vvAzsit61gutTyPQ8F7kSjV5tzu5i
	197lVu9igdd5puy+/XUCNRDzndkIXEfn8WAC8S0aPknWmiPPsxMwrYyS
X-Received: by 2002:a05:6214:2aaa:b0:894:7c5e:3368 with SMTP id
 6a1803df08f44-894e9fb767fmr188217846d6.4.1770080228677; Mon, 02 Feb 2026
 16:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
 <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch> <CADkSEUjEYY=Wwyumv3Ft_T=xWLJY2hiy4uw_YMus=4o=61H+BQ@mail.gmail.com>
 <4b7b8238-3997-45d1-a8ee-b659afc0374c@lunn.ch>
In-Reply-To: <4b7b8238-3997-45d1-a8ee-b659afc0374c@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 16:56:57 -0800
X-Gm-Features: AZwV_QibcfxGBlb6FY5bnd6CK6KIio3ZsP_VQLrtoKrlRtMkrnbOMvIqQ4x18WE
Message-ID: <CADkSEUjxL11fjj4tsxnF6FFtWDP0+Sru45H1sVyOYxPX_S5-3A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6460-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 37E13D32D7
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 1:56=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> You need to be careful with commit messages. Reviewers read them, and
> think about the implications of what they say. As a result, you wasted
> some of my time looking for a driver which did not have an
> module_exit, and wondering if there was a legitimate reason for not
> having it, and had you just broken it....
Sorry about that. Should I send another version with a better commit
message or is this patch okay the way it is?

Ethan

