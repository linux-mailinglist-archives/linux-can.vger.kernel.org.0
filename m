Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A190555302
	for <lists+linux-can@lfdr.de>; Wed, 22 Jun 2022 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377075AbiFVSLX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 22 Jun 2022 14:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359064AbiFVSLX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2022 14:11:23 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41E39814
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2022 11:11:21 -0700 (PDT)
Received: from pps.filterd (m0208801.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MCiF2P001428
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2022 11:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : date : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=samsaracom06092020;
 bh=HvGsLt5EXHvi2guFtIAZ/AcnKpwJH0dmpcWvcI2Opt4=;
 b=vTld7laW3o1jBsaT/DfKv3ko5ss04hROKQq2knDsKaKJCXHS9B3rJLbRNsFJa14/smZK
 Qh9tm+j01b1LwxroW+6xtz+Y4NNBdYSHJIPvb/Qd1DOsuJ5I+EvlwR9OpV++8CvKHdZ3
 cF0bR7eopfqYpB0NyfvIRshlDW93j4N3Y9y+jT1YLo6KnJVjDCZWeBQIJy8wp5QtGZNS
 f+SavnvHxBxS25D/yMqorHgZULQ73JKbbMDjqdWJEkNGY7Qv0UOaS+ubYbtKZK7tJ2/I
 ynpu/e23l4hafdVtghHeZ6GvwB7SmGrA52yd5M39L/SdrIg/DlL2j5sLi+X+s0+LwKu1 7A== 
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gscxuu3ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2022 11:11:21 -0700
Received: by mail-qv1-f72.google.com with SMTP id kd24-20020a056214401800b0046d7fd4a421so17958874qvb.20
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2022 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HvGsLt5EXHvi2guFtIAZ/AcnKpwJH0dmpcWvcI2Opt4=;
        b=U+YRgxijmKrcDVFybozGCEuwPofKAdf1v7k5TADTIx9ZntW0L64eIFzq/VyGcvRiuN
         xz07pQDm8PyRZ736WBjk82J8Sa535LYXte36usqJwhpb4Kh1fee3T1unQJ8L4CAOFru9
         Ju8rkkhgvIvsOkl3GiNKwpKToWEhwczgW5+55JqT9KSMs+D8pjdxTPVBL+7KOQzMLD3y
         mWIaww4aZZNi/4Ev1W+ydLHnv9yF0V0Q7k5TkKRaNQtYpglGmQrFUcbiTwxgTuwSfJaD
         DnJBvz0Ko/JskQ1HSmG3gkRmA10nidSdRUhnT8+vwaFvNCWNzy9E25e+YFuAmAGwXIoh
         RSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HvGsLt5EXHvi2guFtIAZ/AcnKpwJH0dmpcWvcI2Opt4=;
        b=WQlw9MOnA3h8aeT4m/QAciWT0soyDuZ0nfUxn92xp4eYcuDyoz1goUneZmXoi+bAzt
         vIi1aqOt1gyOJr3Af7coVwJ4ggrYuMIM2LGCmkXtrfNUl7DQ6x1mizQeVHff+e4ZjVh3
         jOcK9SyE7HXF86Zxywi8KB8N/wHF96xj2+RhgWUIYcLXuuEUhNNkrZ6+PFAUIHWgdcWJ
         ywDZbDCKrT9R0rXm8djvhUOU6R5njWusXZxU4y5igeSjiW6T0BYD23STJeu/CLny/dAA
         1E2BmwtX+t1w36cz4NE9I70Ln0qtaHz+tqEWFGHw7F+OorR+9+wwYJNu7eegcve1+5xz
         qiVA==
X-Gm-Message-State: AJIora/6f1JJkJRAMPU37cA1X7YFkiIbF/aqv2ZaqxT3KJEi2+Vso2cS
        RNZZ7edaw1Yko4KUDqdM3y0ZDtpisP8kEuZXw8h6KZd1o4I6v/B3rCLWVkSx0TGrNml5uxD52gH
        7xs5gyKQPTwIxX5AZrT+m
X-Received: by 2002:ac8:5793:0:b0:304:ffe3:d3c5 with SMTP id v19-20020ac85793000000b00304ffe3d3c5mr4285910qta.460.1655921480232;
        Wed, 22 Jun 2022 11:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sZB8IG6U8Y8LxhrdfW/XmoMZfW0T4tSLiONYu9WwZm1pSx2JIse9iL2zeM88KooJAW1i4BSA==
X-Received: by 2002:ac8:5793:0:b0:304:ffe3:d3c5 with SMTP id v19-20020ac85793000000b00304ffe3d3c5mr4285863qta.460.1655921479836;
        Wed, 22 Jun 2022 11:11:19 -0700 (PDT)
Received: from downhome (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id e15-20020ac85dcf000000b00304ec60f711sm16396256qtx.39.2022.06.22.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 11:11:18 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
X-Google-Original-From: Rhett Aultman <rhett@samsara.com>
Date:   Wed, 22 Jun 2022 14:11:16 -0400 (EDT)
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
In-Reply-To: <CAMZ6RqJZKYOTtLpiM3ie3fNOBm8i7d8yr8n7S=yAm6twbuhGrQ@mail.gmail.com>
Message-ID: <99ac782c-46e7-bbef-8f54-cf2fd67acdc@samsara.com>
References: <20220610213335.3077375-2-rhett.aultman@samsara.com> <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de> <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com> <YrHM8mqG3WVVesk4@kroah.com> <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu> <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com> <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com> <YrLjsAOlsizMc/1c@kroah.com> <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com>
 <YrMJ0vXR84cISTse@kroah.com> <CAMZ6RqJZKYOTtLpiM3ie3fNOBm8i7d8yr8n7S=yAm6twbuhGrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-GUID: Pssqa9N1Yq7AmvDOc4zLjDtrMYtWRQAR
X-Proofpoint-ORIG-GUID: Pssqa9N1Yq7AmvDOc4zLjDtrMYtWRQAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_05,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=643 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On Thu, 23 Jun 2022, Vincent MAILHOL wrote:

> On Wed. 22 Jun 2022 at 21:24, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jun 22, 2022 at 07:34:57PM +0900, Vincent MAILHOL wrote:
> > > On Wed. 22 Jun 2022 at 18:44, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Wed, Jun 22, 2022 at 09:22:12AM +0000, David Laight wrote:
> > > > > From: Vincent MAILHOL
> > > > > > Sent: 21 June 2022 16:56
> > > > > >
> > > > > > On Wed. 22 Jun 2022 at 00:13, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > > > > On Tue, Jun 21, 2022 at 11:59:16PM +0900, Vincent MAILHOL wrote:
> > > > > > > > I (probably wrongly) assumed that urb::transfer_buffer_length was the
> > > > > > > > allocated length and urb::actual_length was what was actually being
> > > > > > > > transferred. Right now, I am just confused. Seems that I need to study
> > > > > > > > a bit more and understand the real purpose of
> > > > > > > > urb::transfer_buffer_length because I still fail to understand in
> > > > > > > > which situation this can be different from the allocated length.
> > > > > > >
> > > > > > > urb->transfer_buffer_length is the amount of data that the driver wants
> > > > > > > to send or expects to receive.  urb->actual_length is the amount of data
> > > > > > > that was actually sent or actually received.
> > > > > > >
> > > > > > > Neither of these values has to be the same as the size of the buffer --
> > > > > > > but they better not be bigger!
> > > > > >
> > > > > > Thanks. Now things are a bit clearer.
> > > > > > I guess that for the outcoming URB what I proposed made no sense. For
> > > > > > incoming URB, I guess that most of the drivers want to set
> > > > > > urb::transfer_buffer once for all with the allocated size and never
> > > > > > touch it again.
> > > > > >
> > > > > > Maybe the patch only makes sense of the incoming URB. Would it make
> > > > > > sense to keep it but with an additional check to trigger a dmesg
> > > > > > warning if this is used on an outcoming endpoint and with additional
> > > > > > comment that the URB_FREE_COHERENT requires urb::transfer_buffer to be
> > > > > > the allocated size?
> > > > >
> > > > > IIRC urb are pretty big.
> > > >
> > > > What exactly do you mean by "pretty big" here?  And what is wrong with
> > > > that, I have never seen any issues with the current size of that
> > > > structure in any benchmark or performance results.  All USB bottlenecks
> > > > that I know of are either in the hardware layer, or in the protocol
> > > > layer itself (i.e. usb-storage protocol).
> > > >
> > > > > You'd be unlucky if adding an extra field to hold the allocated
> > > > > size would ever need more memory.
> > > > > So it might just be worth saving the allocated size.
> > > >
> > > > Maybe, yes, then we could transition to allocating the urb and buffer at
> > > > the same time like we do partially for iso streams in an urb.  But that
> > > > still might be overkill for just this one driver.
> > >
> > > Well, I wouldn't have proposed the patch if it only applied to a
> > > single driver. If we add a urb::allocated_transfer_size as suggested
> > > by David, I believe that the majority of the drivers using DMA memory
> > > will be able to rely on that URB_FREE_COHERENT flag for the garbage
> > > collection.
> > >
> > > The caveat, as you pointed before, is that the developper still needs
> > > to be aware of the limitations of DMA and that it should not be freed
> > > in an IRQ context. e.g. no call to usb_kill_anchored_urbs() or other
> > > functions that would lead to urb_destroy().
> > >
> > > > I'm curious as to why
> > > > a slow and tiny protocol like CAN needs to use usb_alloc_coherent() for
> > > > its buffers in the first place.
> > >
> > > The CAN protocol, in its latest revision, allows for transfer speed up
> > > to ~5Mbits. For low performance CPUs, this starts to be a significant
> > > load. Also, the CAN PDU being small (0 to 64 bytes), many small
> > > transfers occur.
> >
> > And is the memcpy the actual issue here?  Even tiny cpus can do large
> > and small memcopy very very very fast.
> >
> > > Unfortunately I did not do any benchmark myself so I won't be able to
> > > back my explanation with numbers.
> >
> > That might be the simplest solution here :)
>
> Yes, this would give a clear answer whether or not DMA was needed in
> the first place. But I do not own that gs_usb device to do the
> benchmark myself (and to be honest I do not have time to dedicate for
> this at the moment, maybe I will do it later on some other devices).
>
> Has anyone from the linux-can mailing list ever done such a benchmark?
> Else, is there anyone who would like to volunteer?

I have access to a couple of gs_usb devices but I am afraid I have no
experience performing this sort of benchmarking and also would have to
squeeze it in as a weekend project or something similar.  That said, if
someone's willing to help step me through it, I can see if it's feasible
for me to do.

That said, the gs_usb driver is mostly following along a very well
established pattern for writing USB CAN devices.  Both the pattern
followed that created the memory leak, as well as the pattern I followed
to resolve the memory leak, were also seen in the esd2 USB CAN driver as
well, and likely others are following suit.  So, I don't know that we'd
need to keep it specific to gs_usb to gain good information here.

Best,
Rhett
