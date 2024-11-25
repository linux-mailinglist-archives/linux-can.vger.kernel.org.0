Return-Path: <linux-can+bounces-2208-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726F9D7CDF
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 09:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57BA1633FC
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2461718B47C;
	Mon, 25 Nov 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CbmRtSDz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HmS2xztr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CbmRtSDz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HmS2xztr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D318A6C1
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523187; cv=none; b=Aif8DjImJ7y3e8gZeBHqMOGtF4FiEOFJtZKDVJXwZfAwkyajXHU/ORdxbYOH05qtNjFNdIOu2LC4xabeypPqPKrRjoKq+95aSuZfcw/16chiSekrarRoOvtUK2dXWgRTeL3JDKnBZStg191z+6pBWuY8PkbiqtHTqmL30Kb2xvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523187; c=relaxed/simple;
	bh=mKhrn3Edw8sVQifHb0Rrs9iBsJ1XYC+y0Hb8z7HjCQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaqOPcoj8b6IkbvGbGyVyyUmJbQVCWCJAfsX5MA/Y1OnJMg6k40ocuvuENq8vSW/wKKEzb8YAAA+frPFo0v4R4kYT0CPtMnG0Mae6JkwVt8r/aHRO8sgsDmQTTvXQLKv0Orq2GZ2bAD6NNkc93HOiQXfVAssaD7jHrZKin+2H3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CbmRtSDz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HmS2xztr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CbmRtSDz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HmS2xztr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C11FA21186;
	Mon, 25 Nov 2024 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732523182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKhrn3Edw8sVQifHb0Rrs9iBsJ1XYC+y0Hb8z7HjCQ0=;
	b=CbmRtSDzvpARHMv0nmQfLOjYjTE3P7F2N5Lc1R624OSFS7LOUxNzlRJ1QWLWNsT/8/e3JB
	SkW2z1KdBX/hz9G5iTE67UqGo4/MBp2glVR/tZj7EplvCt5/56xQUzyu1mYLg41RH3HFIa
	KCX46xfIKEvqwmYRPnBFa8V+l1LQe4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732523182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKhrn3Edw8sVQifHb0Rrs9iBsJ1XYC+y0Hb8z7HjCQ0=;
	b=HmS2xztrPiiWBBUrNlmjMy6CDuyjNfwqlqE1yS9MAkRApgr0Npz3mU9dqVgeafdONiEvgu
	PCQ+2hwiduNgFqCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CbmRtSDz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HmS2xztr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732523182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKhrn3Edw8sVQifHb0Rrs9iBsJ1XYC+y0Hb8z7HjCQ0=;
	b=CbmRtSDzvpARHMv0nmQfLOjYjTE3P7F2N5Lc1R624OSFS7LOUxNzlRJ1QWLWNsT/8/e3JB
	SkW2z1KdBX/hz9G5iTE67UqGo4/MBp2glVR/tZj7EplvCt5/56xQUzyu1mYLg41RH3HFIa
	KCX46xfIKEvqwmYRPnBFa8V+l1LQe4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732523182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKhrn3Edw8sVQifHb0Rrs9iBsJ1XYC+y0Hb8z7HjCQ0=;
	b=HmS2xztrPiiWBBUrNlmjMy6CDuyjNfwqlqE1yS9MAkRApgr0Npz3mU9dqVgeafdONiEvgu
	PCQ+2hwiduNgFqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67B3B137D4;
	Mon, 25 Nov 2024 08:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ThFCF640RGcmTQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 25 Nov 2024 08:26:22 +0000
Date: Mon, 25 Nov 2024 09:26:16 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, Miguel Ojeda
 <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] can: rockchip_canfd: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20241125092616.3b93c2b1@endymion.delvare>
In-Reply-To: <CAMuHMdXU8tMPbHMDZmU=0xd-X6OqxO_3j=iLDR2XQ4q3URw2RQ@mail.gmail.com>
References: <20241022130439.70d016e9@endymion.delvare>
	<CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
	<dcced72-7be1-b44-432a-dac2ad7f4cc6@linux-m68k.org>
	<20241121145017.33ca43f7@endymion.delvare>
	<CAMuHMdXU8tMPbHMDZmU=0xd-X6OqxO_3j=iLDR2XQ4q3URw2RQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C11FA21186
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wanadoo.fr,vger.kernel.org,pengutronix.de,kernel.org,linux-foundation.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Geert,

On Fri, 22 Nov 2024 15:33:21 +0100, Geert Uytterhoeven wrote:
> On Thu, Nov 21, 2024 at 2:50=E2=80=AFPM Jean Delvare <jdelvare@suse.de> w=
rote:
> > Your reasoning would hold only if building a limited, maybe
> > not-working driver, was a purpose in itself. I personally can't see
> > any value in doing this. =20
>=20
> It may help detecting more configuration issues using randconfig.

Maybe I would agree if build time, energy and engineering time were
free and unlimited resources.

In our world though, the time spent by a test build farm to build a
known-crippled driver would be better used to start the next test build
earlier. This makes for better quality coverage. Or the energy used to
do that could also be saved altogether.

And this suboptimal use of build time and energy is only the best case.
The worst case is if the randconfig case causes a "false positive" build
error or warning. This will generate a report, which will be sent to
mailing lists, read by human beings and investigated, wasting
engineering time.

I'm not making this up, this is in fact exactly what happened and led
me to investigate a first "depends on OF || COMPILE_TEST" case a few
years ago. I found out that the build warning would only possibly
trigger if COMPILE_TEST was selected and OF was not. It would never
trigger with any configuration options combination not including
COMPILE_TEST. Fixing it would require adding #ifdefs and using macros.
But why should we make the code more complex, less readable, to prevent
a warning which can never happen in a non-test scenario? And more
importantly, why should we allocate engineering time to look into such
issues, when there are so many more useful tasks to work on?

--=20
Jean Delvare
SUSE L3 Support

