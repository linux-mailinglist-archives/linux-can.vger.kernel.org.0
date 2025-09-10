Return-Path: <linux-can+bounces-4626-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A1B51139
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 10:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29B4160D0D
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5267E30FC3F;
	Wed, 10 Sep 2025 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnC/5uog"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE430FC0C
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492896; cv=none; b=ObUnJcfMi7OjjT5kqR0V+qmB7PoqDF44bBF/JbrP7d+1eRXb4/Z50paqWTueCC5c0dlwmsLKuHp/tP8U+Hn/CCSvhk2HmyG2BnrcpQrr5Qr/7wgtJz+V/quUYudjEAUlrY34muYzr7UqoRC0zNBPv6W2W/DIJ3rcdK/3Q/IKGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492896; c=relaxed/simple;
	bh=vaX7Ju+p+Z3MWIpBaMIHx9c7/gUB47qSlUxX61hFoPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di7QspJow/qG3IKUmB5DKRdJ/cUkgcvNkBvRJDOxg1IQutHKGJBTzDD974d+IWiIl0ZeitInLFeDO3USV2KjX00Z9zhvROo2yHbcODsLol649THgI0e5UlWYCm6hV35pmHfmrQz1TpOMiozVHsgv9YQvOWKSOgEfpDQmJ83unfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnC/5uog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757492893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lyl88Wjtp1RCxQS+mXtK5muxD+C3zmjvgsqdrJfM01s=;
	b=SnC/5uogLEJ0/LsdWmaacPWyOPv1cxVPX7CNW4CNAdm0R+mTxVo3tJhmp+bVsjrv4+/SFM
	wDZ/RpVhds6c0+lOVq2jP3WEcm1CF/bR3mYVEZwtd23WxC5d0/O3vQ9SJ3VKASuxaW+MT5
	IfmHqnQvLpZqO6nrtcyQ7+i+wY83kPA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-HfCl9NBiPPWt4WRsCJV4sw-1; Wed, 10 Sep 2025 04:28:11 -0400
X-MC-Unique: HfCl9NBiPPWt4WRsCJV4sw-1
X-Mimecast-MFC-AGG-ID: HfCl9NBiPPWt4WRsCJV4sw_1757492890
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45deddf34b9so2333135e9.1
        for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 01:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492890; x=1758097690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyl88Wjtp1RCxQS+mXtK5muxD+C3zmjvgsqdrJfM01s=;
        b=nVa99K1qEr+4bZCAfyNge8/Xz/hPNyNVAzhswK/lfK6rm5sKYDSdFycL11YYx/sASp
         bHQUcF8tx6me0z2prB4CrIm7s47YWScINW+VprEiXlf86r4S+Qn78WVrflxMdP0c+VCo
         6dqrfur/xXj/I4A1WqWeGycrORDUZKcsMf+BamwGwiIg/4WybLssqeH+OWR9i3lOvSsD
         7eDGZl5UMsmnv99U1WFh8bVdMqmAx988QnPjm7FhoECVlNkbbDxKAhNNm5JBuSAoIQ7J
         r8IVRlPwbLetMoRWRjVc1F3nC0NS5kTy3Y6xm3mCQZ/1iCxpLozmb8XcusdQ8F53crri
         HoIg==
X-Forwarded-Encrypted: i=1; AJvYcCWbuRoyNx9jo6hIKpDFG0THgmz+UERWACd43SDTfCHfkFr8YBIKXzocXV2zDdaPmLY7oplq7T46AS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAq6bDSrsZcCR1eWEFHeZRSxjB0c5iGeU81ShShjl0KNoa+FA
	JHeh0OIqjR5Z9MI64wIMfYdE9K4c/Jp46Xrp5FWqGxRkx+nmGqyd+XeLWfbemwTapZoguZwYU5/
	VCrM0efCzFnSOGsoh7jEhoNpn0/fBwYD0evCR7Lu8yquEAvqmCRxQdScOI/lMhQ==
X-Gm-Gg: ASbGncsq6FMP3aQXs42w/ekbU1p/Pn3cK4gecKQmIJETUMbztf46jA1Z3FCM6gOWkLD
	pjgqGFxvaJsmhzDOPfMgRUjcD/YG9Y8wG20OePcvh4Cq3aV9PmCoOYLJZbyCoosnQr+5gzroold
	g56KMtB5XOFph5ntfTd8KMAYXqv8Cx6GKwkHcFARY1NACet0Tqq6d5HRXPO24959I/v62rHo/EC
	nZ2xjMG6dZzYzaV51puulykdnBoECmJ5fz8TChFxteq7R6QNkoDViYFJU/aKsj7WBaPVCasDxoe
	B8kmRnUzduEbKvZtEIx7iha5xWoMD1j3KL+cdg==
X-Received: by 2002:a05:600c:354f:b0:45c:b61a:b1bd with SMTP id 5b1f17b1804b1-45dde220a2emr138989925e9.18.1757492890028;
        Wed, 10 Sep 2025 01:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpcTkn0wW4LsqJDafwujpAjLDY5EPkSvu6F/qT+LDRJgx5vEptRBgEGFHxNaolEYNmPJYzww==
X-Received: by 2002:a05:600c:354f:b0:45c:b61a:b1bd with SMTP id 5b1f17b1804b1-45dde220a2emr138989665e9.18.1757492889566;
        Wed, 10 Sep 2025 01:28:09 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df821f714sm18713505e9.16.2025.09.10.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:28:09 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:28:08 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
	kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a
 module
Message-ID: <aME2mCZRagWbhhiG@dcaratti.users.ipa.redhat.com>
References: <20250909134840.783785-1-mkl@pengutronix.de>
 <20250909134840.783785-3-mkl@pengutronix.de>
 <00a9d5cc-5ca2-4eef-b50a-81681292760a@ovn.org>
 <aMEq1-IZmzUH9ytu@dcaratti.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMEq1-IZmzUH9ytu@dcaratti.users.ipa.redhat.com>

hi,

On Wed, Sep 10, 2025 at 09:37:59AM +0200, Davide Caratti wrote:
> > ...
> > # 4.13 [+0.00] # Exception| lib.py.utils.CmdExitFailure: Command failed:
> >         ['ip', '-netns', 'rhsbrszn', 'link', 'add', 'foo', 'type', 'vxcan']
> > # 4.14 [+0.00] # Exception| STDERR: b'Error: Unknown device type.\n'
> > 
> 
> > Best regards, Ilya Maximets.
> 
> thanks for spotting this, I was testing the patch with:
> 
>  # vng --kconfig
>  # yes | make kselftest-merge
>  # grep ^CONFIG_CAN .config
> 
> Then it's probably safer to drop the first hunk - or restore to v1
> 
> https://lore.kernel.org/linux-can/fdab0848a377969142f5ff9aea79c4e357a72474.1755276597.git.dcaratti@redhat.com/

And I see that the build [1] is doing:

  CLEAN   scripts
  CLEAN   include/config include/generated arch/x86/include/generated .config .config.old .version Module.symvers
> TREE CMD: vng -v -b -f tools/testing/selftests/net/config -f tools/testing/selftests/net/af_unix/config
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o

[1] https://netdev-3.bots.linux.dev/vmksft-net/results/291401/build/stdout 

while the enablement of CONFIG_CAN_VCAN is still necessary, the contents of selftests/net/config need to be preserved.
@Jakub,  @Marc, we can drop this patch from the series and I will respin to linux-can ? or you can adjust things in other ways?
-- 
davide


