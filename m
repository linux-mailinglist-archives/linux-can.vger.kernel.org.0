Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF443C7F34
	for <lists+linux-can@lfdr.de>; Wed, 14 Jul 2021 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbhGNHS3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Jul 2021 03:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238079AbhGNHS3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Jul 2021 03:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626246937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCHPfZDQwNHkHzCfWYGDtKtfXmWuDaVjFGpyY2y3opo=;
        b=imW3Bv8plaQyTNv6GARpsJwBXMIkTiDXBUNn4BN2Z27WZbRQbBgh3OMNsnc8XFvnD6Ueas
        zylo4ov4clk4pRU91ql2ZpVhzoHQ0VO+MbKiGBHcilEngAXcYPEELWrsBhQhPAueFgeBVe
        gToBKYhzJVCVOHEs5JjBCi7990x3z1o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-3bOn-IX5O3mhVmm-fctNRA-1; Wed, 14 Jul 2021 03:15:35 -0400
X-MC-Unique: 3bOn-IX5O3mhVmm-fctNRA-1
Received: by mail-wm1-f72.google.com with SMTP id o18-20020a05600c5112b029022c3d638485so404477wms.2
        for <linux-can@vger.kernel.org>; Wed, 14 Jul 2021 00:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JCHPfZDQwNHkHzCfWYGDtKtfXmWuDaVjFGpyY2y3opo=;
        b=XDTSdK6KuWNOwVbcONsvuCUewznlBk1LdgCDl14XEm1OrbIznc8LO1hGwa6qozz7r2
         yYZS7Ngg/nd+n5z1WsV13u2WO0CqJQRBpN2/zoivv8cC+NLwDb2sKhfw0BXYXoTeVo4I
         lEKMgqglWUxjDVmsxZ4pxCoUtqOKPrhhX93NgEUYSA13IOKvdtTg7q8vdbmRp4GXTmYA
         WBedcS1x/eBuDSJcdacN/byP6HnDXXHgQ92/6A8k9JBws4XjAF90QO0AD5Uos9F+RHqd
         dXLjkW/8jSnFt/ODEVzukPKu2YVrUprPm9fSsqjHHREGaDYrFeVDLhv9/OVwki34P7/U
         oGhA==
X-Gm-Message-State: AOAM531ofZ95OAbRtkN1UnyDhC9RV8obl8G6bcl7Pch6MBXQtnfQK2/0
        nIhhOYYY9CTxRafak3xj3H5F0odz6KzRXXkjDoWihsgb3asLTQfeQs4U3XXyAxdMfuZKCJ0HiIg
        8xjVyvThEF3YTB2G/9S4e
X-Received: by 2002:adf:eb43:: with SMTP id u3mr11071415wrn.83.1626246934688;
        Wed, 14 Jul 2021 00:15:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8ztYXeJKfzOSVzqZbNHWPGVbjdP1ZnQZA8/4Tv1My8NwPl+PB2tb3VjOWeI923M8U8lwELw==
X-Received: by 2002:adf:eb43:: with SMTP id u3mr11071401wrn.83.1626246934545;
        Wed, 14 Jul 2021 00:15:34 -0700 (PDT)
Received: from redhat.com ([2.55.15.23])
        by smtp.gmail.com with ESMTPSA id c10sm1145203wmb.40.2021.07.14.00.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 00:15:33 -0700 (PDT)
Date:   Wed, 14 Jul 2021 03:15:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Harald Mommer <hmo@opensynergy.com>, linux-can@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] review of virtio-can (was: Re: MSG_CONFIRM RX
 messages with SocketCAN known as unreliable under heavy load?)
Message-ID: <20210714031300-mutt-send-email-mst@kernel.org>
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
 <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jun 25, 2021 at 11:19:38AM +0200, Marc Kleine-Budde wrote:
> On 24.06.2021 17:21:15, Harald Mommer wrote:
> > First draft went to virtio-comment@lists.oasis-open.org and
> > virtio-dev@lists.oasis-open.org.
> > 
> > https://markmail.org/search/?q=virtio-can&q=list%3Aorg.oasis-open.lists.virtio-comment#query:virtio-can%20list%3Aorg.oasis-open.lists.virtio-comment+page:1+mid:hdxj35fsthypllkt+state:results
> 
> > [virtio-dev] [PATCH 1/1] [RFC] virtio-can: Add the device specification.
> > Harald Mommer Thu, 01 Apr 2021 08:21:09 -0700
> > 
> > virtio-can is a virtual CAN device. It provides a way to give access to
> > a CAN controller from a driver guest. The device is aimed to be used by
> > driver guests running a HLOS as well as by driver guests running a
> > typical RTOS as used in controller environments.
> 
> Let's open the focus of this driver and not limit us to RTOSes.
> 
> > ---
> >  content.tex      |   1 +
> >  introduction.tex |   3 +
> >  virtio-can.tex   | 245 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 249 insertions(+)
> >  create mode 100644 virtio-can.tex
> > 
> > diff --git a/content.tex b/content.tex
> > index e536fd4..c1604db 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -6564,6 +6564,7 @@ \subsubsection{Legacy Interface: Framing 
> > Requirements}\label{sec:Device
> >  \input{virtio-mem.tex}
> >  \input{virtio-i2c.tex}
> >  \input{virtio-scmi.tex}
> > +\input{virtio-can.tex}
> >  
> >  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >  
> > diff --git a/introduction.tex b/introduction.tex
> > index 7204b24..84ea5c0 100644
> > --- a/introduction.tex
> > +++ b/introduction.tex
> > @@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative References}
> >         \phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
> >         Arm System Control and Management Interface, DEN0056,
> >         \newline\url{https://developer.arm.com/docs/den0056/c}, version C and 
> > any future revisions\\
> > +       \phantomsection\label{intro:CAN_Driver}\textbf{[CAN Driver]} &
> > +       Specification of CAN Driver -- AUTOSAR CP R20-11,
> 
> As mentioned before don't make this AUTOSAR specific.

If the specs are more or less identical it might be worth it to link
to AUTOSAR too just because it can be downloaded for free.

-- 
MST

