Return-Path: <linux-can+bounces-2254-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5559DB51B
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5CC2B2587C
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE0146590;
	Thu, 28 Nov 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b="feQ1G1vY"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB2288DB
	for <linux-can@vger.kernel.org>; Thu, 28 Nov 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787604; cv=none; b=PZEhA2LuZX5yjfEajMyIYHcZWl6mG3/wOsVNOrTlYz2VVgskm97P8vhNdfg9T0pmFO+V/KHBNzEl15B1PMj0YcrCxeLTWug0/h1nIC7pzMLvlFMpiihpF77MbLVx9Isds8VG4UQTbOZpdsmH6zhqxVuPNwqBr8I7j4TtsKfOjbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787604; c=relaxed/simple;
	bh=FpnpCo4d/ONf/ciueGWEH0FBiA6VO/UJSJGNq8ydKUg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dvne3eobXuq2Vxx+az2cQniFci7ZAfz02hU90um16eZvIbXjTQnkAuX17PvNtHHL15wcCvke9voK/uFmf6YIhz2Qfz6KeNGWgpZB1TsKNe/ZNaK/iDWujlX9MxRRFKSL+N351RIs6zK6fkFGNZ3OvBGu/xBiyoGroavax3Q9L+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com; spf=pass smtp.mailfrom=geotab.com; dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b=feQ1G1vY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geotab.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa5500f7a75so86422766b.0
        for <linux-can@vger.kernel.org>; Thu, 28 Nov 2024 01:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geotab.com; s=google; t=1732787600; x=1733392400; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FpnpCo4d/ONf/ciueGWEH0FBiA6VO/UJSJGNq8ydKUg=;
        b=feQ1G1vY0G2n8fhk9LZ/rE//C1wWPuZKGXzmck6vQX/Wh37i4e2XgmhDlfcE2sKxx7
         m3kfs+RLTMHgyskBgveq8Y3TaTP0oH31LqkgYpEGZitQigaFfs62va4ASJW3IyhyoFyi
         BloSAsCoVdxBWUoC8noT7Q9Xrgxra2TyI/5e9zlv7tG0xcN+7cg3UaNrv4Hf0ctxkEG8
         km+wOMoBAhQbgnmstIqIbuuof6KGraZfl43hKe66TbXsd4l3wTE02Krmo43HJy3J3u4S
         nmw06+T++YbOWiE6e5pl85p+4dIHAR+ZZKWx6hIbKaDZcjjvYwyJEEiEwL/eHmRIvbKl
         VV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732787600; x=1733392400;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpnpCo4d/ONf/ciueGWEH0FBiA6VO/UJSJGNq8ydKUg=;
        b=Mpd+NaySFBuGfPZOGAbr3SB9RsCKgGmAarUMvZ/l4SYmniYjwXeByvByLNOz01iYNJ
         T4fUwY+kj0+5QY2XbmX1h6VD3eW+lTTPKRJMvckSNQBHLXyVuYbd+w3eWX2EIVzZovw/
         vsoUZsi1+MXl5Hf6XBkrKr6CMPmMKrfljC1pUBDvm3MciokzCF4GFuJlqvdzBcntxSBU
         slLoMkcItGh2N7PyfGM4WGANf1a5Leo1ITUp3lfbOLN4gLM/xfAY3Re4n7bBN4XxcRMz
         0ZO9/XhN+SknfiQtyfuIlg+bcI4F/8yVbVliHb3NoeUgdbwXTkNAT19m6LspgDM45QSF
         P6eg==
X-Gm-Message-State: AOJu0YzD2Ciwwly1zfEpNhTtYMUx8J/sp6ACePDFFtX3qPM2hvsOyqHM
	CI3pV95faCMxrgs9xbQiyBPhmrMT4d06s5VxDJdnzby6zxlZqnwZOA5g65wU50GwmVuQ0xeLKbr
	iTe+UjOfvwHJpXKmfOChb0IJHYVsPlE6m5mN2qorJ1oLlZgyUPcY=
X-Gm-Gg: ASbGnctyJ5nvCoGD+cfwjJ9RhAuaKeHB5p/fkcm2kQb+K+u2hmL14kbEvwaSaRcllTj
	W5JRwWkcSkCqB8HubseckFAAAurS+6q8=
X-Google-Smtp-Source: AGHT+IHeTpRz/mXchZHdap1mpTOcIb+XgSmBdfL1J0qd01lc/nqMWFugenfx2U8/nxZCmdg4gqn2KRSmpoXLRHSabkE=
X-Received: by 2002:a17:907:84d6:b0:a9e:b5d0:4ab7 with SMTP id
 a640c23a62f3a-aa581081a72mr421863166b.52.1732787600140; Thu, 28 Nov 2024
 01:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesus Jorge Serrano <jesusjorgeserrano@geotab.com>
Date: Thu, 28 Nov 2024 10:52:44 +0100
Message-ID: <CADRc_D-e01HHmeP39Aa6EFqfPX+ji1brZe1pvke-n3u7-kp3ow@mail.gmail.com>
Subject: socketcand FD configuration proposal
To: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I just proposed this MR in the socketcand repo to implement CAN
configuration commands using libsocketcan to do it:
https://github.com/linux-can/socketcand/pull/35

Currently, I am working in supporting also CANFD configuration (with
bitrate and dbitrate) and I would like to propose a new configuration
keyword for that configuration just in case you find it useful for
future implementations.

Similar to the current CAN configuration:

< can0 B bitrate sample_point tq prop_seg phase_seg1 phase_seg2 sjw brp >

We can use a parallel keyword for FD mode:

< can0 F bitrate dbitrate sample_point tq prop_seg phase_seg1
phase_seg2 sjw brp >

This is just a proposal I will implement internally for my project,
but if you think it could be applicable for the mainstream, we can
discuss about the format or alternative options.

Regarding the implementation, I know libsocketcan doesn't support
currently CAN-FD configuration, it is a thing should be rethough when
we reach that point.

BR,

Jesus

