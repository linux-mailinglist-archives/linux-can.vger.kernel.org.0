Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0193D6FFD
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2019 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfJOHNQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Oct 2019 03:13:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33649 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfJOHNQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Oct 2019 03:13:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id c4so16984772edl.0
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2019 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=42biyvPrM31S02FsXUC0MU+0R6tD+Grhb6Q0nsVz7Ds=;
        b=07Ro9DoDUOV+hGr1z0pDvrhKuUGay3/l/niOQeWdwuMjtweQYy+ib4C04lop8neHRr
         /Cofqv91xBd/zu/rW9CypWngXIM8TzIgl7XxcJ67lxemRhucFI/u0g+2HAA2gxwqVhV4
         KqjjYjMw/bYk4EUR3ureh4UkvD30pN6OGzo7UscckZ+S3FknLUL4VY6kDkP308LPA9Qv
         +XgM84b5fGWauxm24KYhW7chdXFiPbnB+lPx7pvpaM8TF7/bwjeY+xAbZlerS3cMLFnc
         wXw7GCgaF9SCJDU0+TrJoSNVDxpbaodv03bNgmVOZQrJVvsgmSe2MS3nmbgHgPnPdvBQ
         hnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=42biyvPrM31S02FsXUC0MU+0R6tD+Grhb6Q0nsVz7Ds=;
        b=rVT2UPGUU1QPNtX5BSieIUNQk1jjdZckRGiKxy96KeqM6FpXK04tZ26Pay1icdDL1t
         6cL9NbOrF6ikmFpoAQkK5zv7Ih+d+hoc01K5sbQ4p5ZVTRzRBFl+9v4+Ke8g7mDL37wo
         M+Ky0+0xqG87zDCNqxX4gEdOL8S7f2n0bq3CpuYbAURdBopOjsIPoHyePqP0gScBJd7N
         V3Q3vDRvIQaeiEcXqSGPPtW9ZGemyqsSoRvxx3nmQXfxoSwcJNe5ml9l6xZFNpupMpvP
         qgX/RHDUtjCXHQC5LO6GDPz04QrhmAULdBkyO2qVfNUtUKMvAIuclZYM68yNMIovdvvh
         JbLQ==
X-Gm-Message-State: APjAAAX0tBoZ400AVIwwZ9/8Kx9DEmjCqPlr4PXvfAz9UTGQO2h7We5U
        081A30W4uCahdIT9nYIhvnUXMw==
X-Google-Smtp-Source: APXvYqzkDKmEoyVN1f2OTnxxt1B+9UZ1DrV5ZExNh0mPSF0Uip8kLTW7XTtAyZQSYQT8uaXQrE7MCQ==
X-Received: by 2002:a50:bac2:: with SMTP id x60mr31916901ede.96.1571123594739;
        Tue, 15 Oct 2019 00:13:14 -0700 (PDT)
Received: from netronome.com (penelope-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:c685:8ff:fe7c:9971])
        by smtp.gmail.com with ESMTPSA id p4sm3575649eda.56.2019.10.15.00.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 00:13:13 -0700 (PDT)
Date:   Tue, 15 Oct 2019 09:13:12 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "pankaj.dubey@samsung.com" <pankaj.dubey@samsung.com>,
        "rcsekar@samsung.com" <rcsekar@samsung.com>,
        Sriram Dash <sriram.dash@samsung.com>
Subject: Re: [PATCH] can: m_can: fix boolreturn.cocci warnings
Message-ID: <20191015071311.yssgqhoax46lfa7l@netronome.com>
References: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
 <20191014150428.xhhc43ovkxm6oxf2@332d0cec05f4>
 <20191015055718.mypn63s2ovgwipk3@netronome.com>
 <9ad7810b-2205-3227-7ef9-0272f3714839@victronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad7810b-2205-3227-7ef9-0272f3714839@victronenergy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Oct 15, 2019 at 06:37:54AM +0000, Jeroen Hofstee wrote:
> Hi,
> 
> On 10/15/19 7:57 AM, Simon Horman wrote:
> > On Mon, Oct 14, 2019 at 11:04:28PM +0800, kbuild test robot wrote:
> >> From: kbuild test robot <lkp@intel.com>
> >>
> >> drivers/net/can/m_can/m_can.c:783:9-10: WARNING: return of 0/1 in function 'is_protocol_err' with return type bool
> >>
> >>   Return statements in functions returning bool should use
> >>   true/false instead of 1/0.
> >> Generated by: scripts/coccinelle/misc/boolreturn.cocci
> >>
> >> Fixes: 46946163ac61 ("can: m_can: add support for handling arbitration error")
> >> CC: Pankaj Sharma <pankj.sharma@samsung.com>
> >> Signed-off-by: kbuild test robot <lkp@intel.com>
> >> ---
> >>
> >> url:    https://github.com/0day-ci/linux/commits/Pankaj-Sharma/can-m_can-add-support-for-handling-arbitration-error/20191014-193532
> >>
> >>   m_can.c |    4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> --- a/drivers/net/can/m_can/m_can.c
> >> +++ b/drivers/net/can/m_can/m_can.c
> >> @@ -780,9 +780,9 @@ static inline bool is_lec_err(u32 psr)
> >>   static inline bool is_protocol_err(u32 irqstatus)
> >>   {
> >>   	if (irqstatus & IR_ERR_LEC_31X)
> >> -		return 1;
> >> +		return true;
> >>   	else
> >> -		return 0;
> >> +		return false;
> >>   }
> >>   
> >>   static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
> >>
> > <2c>
> > Perhaps the following is a nicer way to express this (completely untested):
> >
> > 	return !!(irqstatus & IR_ERR_LEC_31X);
> > </2c>
> 
> 
> Really...., !! for bool / _Bool types? why not simply:
> 
> static inline bool is_protocol_err(u32 irqstatus)
> 	return irqstatus & IR_ERR_LEC_31X;
> }

Good point, silly me.
