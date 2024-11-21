Return-Path: <linux-can+bounces-2159-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78E9D4E1A
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 14:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28012828A0
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4601C7B99;
	Thu, 21 Nov 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e9FQThjJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Socn9v+i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v+Gfmc7W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="25ILzwzt"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9921F5E6
	for <linux-can@vger.kernel.org>; Thu, 21 Nov 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197024; cv=none; b=iw+tV82vAriPBMtEfTxOSDrgXqRfUig0XtQm+l4/9FDUYGQzugLSC9JXcYm3R3mu03gGx13Shk+3/eVo5+w6fGles6QENSpV24gk8TcRgeKF2h/Hl5h553xZs0fpYMoaIGHjSVDx3AbA1MCXtM75ql+hfjLm5Z35lkCfeJalgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197024; c=relaxed/simple;
	bh=AzU8hiW5tGF8IWwjhuEw0+yLUqJYjSoYP8VeWAvSI7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gczukmRTGOLWyXNb/Xo/R7n/4WQ7Jko17Be2dBUN6f+IGtXCTdc4wF0Ak1GPmIu28spaiUPJXBQHAQDBrN8oi3peLNjbZ4trd9tbxCZAJb1x/4VliuggtBwiqpv4PTIcid1EyTOBVWYOvFPpA/q1Wu0UjEe/6axDCgB+OnnRbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e9FQThjJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Socn9v+i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v+Gfmc7W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=25ILzwzt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77C441F803;
	Thu, 21 Nov 2024 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732197020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cr/voIMkwBI2xLzZ9dqn+XGg+cyeq/0+BVCjznbBbo=;
	b=e9FQThjJcJWEcVXXkt8p7G8RXWl3XFe01oYML1q3taEqM3OvwWwjzt2KM1jShy+fx5NmsR
	2zXjdt3ilE5jkn2PpOytYq5L/Lv04tFDFbiG52h9Ax3Vy/6VI61l2vga3G0d2747PHou/4
	/gAZroQGbfvLYCib792c1cCAf/R0vQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732197020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cr/voIMkwBI2xLzZ9dqn+XGg+cyeq/0+BVCjznbBbo=;
	b=Socn9v+iUVD0DbbfMcqvXhZS0iv17mzuEFMhu0zbix5J2b5iJepsdUm+xH19daz3ZFVHDe
	Lw9i2P5MXHDZxGCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v+Gfmc7W;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=25ILzwzt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732197019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cr/voIMkwBI2xLzZ9dqn+XGg+cyeq/0+BVCjznbBbo=;
	b=v+Gfmc7WG4qjnbai7r0TMxbJV2vGjWfE6mwWfmBODw+M04RcMNzfpu0liveVrO4ZAkt9V7
	gk3ZLF2Le5QcuE7HPGrRMgl3JSesOtpq0I9gu87SWu9v/cLYAPPg7mihL+KfpUbozEaDER
	VnZDLZ0bX0shNcILdNboU4e5onTfNxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732197019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cr/voIMkwBI2xLzZ9dqn+XGg+cyeq/0+BVCjznbBbo=;
	b=25ILzwztcMTGXSzBCis1e4hBhs9r/jgMF20K+43Zm4Oj417aTSEylnUM9aOOpe9C7iHU0w
	A7PNsHbjuXNaWxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE5F13927;
	Thu, 21 Nov 2024 13:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EYQzBZs6P2eRLgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 21 Nov 2024 13:50:19 +0000
Date: Thu, 21 Nov 2024 14:50:17 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, Miguel Ojeda
 <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] can: rockchip_canfd: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20241121145017.33ca43f7@endymion.delvare>
In-Reply-To: <dcced72-7be1-b44-432a-dac2ad7f4cc6@linux-m68k.org>
References: <20241022130439.70d016e9@endymion.delvare>
	<CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
	<dcced72-7be1-b44-432a-dac2ad7f4cc6@linux-m68k.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 77C441F803
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	FREEMAIL_CC(0.00)[wanadoo.fr,vger.kernel.org,pengutronix.de,kernel.org,linux-foundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[endymion.delvare:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi Geert,

On Tue, 12 Nov 2024 12:15:06 +0100 (CET), Geert Uytterhoeven wrote:
>  	Hi Jean, Vincent,
> 
> On Tue, 22 Oct 2024, Vincent MAILHOL wrote:
> > On Tue. 22 Oct. 2024 at 20:06, Jean Delvare <jdelvare@suse.de> wrote:  
> >> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), OF
> >> can be enabled on all architectures. Therefore depending on
> >> COMPILE_TEST as an alternative is no longer needed.  
> >
> > I understand the motivation behind this patch, but for me, as a
> > maintainer, it becomes more work when I want to do a compile test.
> > Before I would have needed to only select COMPILE_TEST but now, I
> > would need to remember to also select OF for that driver to appear in
> > the menuconfig.  
> 
> IMHO these are two different things: to get a working driver, you need
> to enable OF;

True.

>(...) to do (may be limited, i.e. may not give a working driver)
> compile-testing, you need to enable COMPILE_TEST.

No, you don't *need* it. Enabling COMPILE_TEST is (or was) one way to
do compile-testing, but it was not the only way. Which is the reason
why it was dropped.

Your reasoning would hold only if building a limited, maybe not-working
driver, was a purpose in itself. I personally can't see any value in
doing this.

-- 
Jean Delvare
SUSE L3 Support

