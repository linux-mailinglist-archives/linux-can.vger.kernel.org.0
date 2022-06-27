Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D734055D84E
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbiF0TYy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Jun 2022 15:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiF0TYv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 15:24:51 -0400
Received: from mx0b-0054a801.pphosted.com (mx0b-0054a801.pphosted.com [205.220.172.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5A465B8
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 12:24:50 -0700 (PDT)
Received: from pps.filterd (m0208804.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDlEGk011254
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 19:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : date : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=samsaracom06092020;
 bh=MQ3ZpAPeNHg1Ef0teanT2VmVPWPfDvQemS8HKBKQCAc=;
 b=G2eLFwtopLkpiEgQYSokifzmyeRiwsOAwENeoDaUUae9fLwgfihWPe+INayfMzP+gZep
 O5Ihmdh9ChfX6hsSafi/d1mvOsMyfKDnTcBSY8ZMJVF1vfZfaXf4yeesj8Dyci+rVMLc
 /+by6buU9thX8WcBMQWskCm2DvvQXRzw2K2REvQURw7f7ZdpRbrRAfAosS3quZeSsXvT
 f89NAKERHjhuGxLFj1WsgIezBHfQBOjrNT50a4TS/BxIXCqN2WJv8RqKt8kBhCWTWZn6
 UDqRoHVlNPrjl1zA/VnCm7iPe+m5nBLJT6rYBcA+MP4bX0v1gYsGj5I2cCHo7ZuqSmh2 YA== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gwry5hk3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 19:24:47 +0000
Received: by mail-qk1-f197.google.com with SMTP id g194-20020a379dcb000000b006aef700d954so11014423qke.1
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MQ3ZpAPeNHg1Ef0teanT2VmVPWPfDvQemS8HKBKQCAc=;
        b=dikKWBOK8s1R4bO9+mBf7p1/tD5HTerzW0vTf4I3oyY7AP6SRB9dROLTezMWGYvhtG
         wOcZFcwCWaW9zGwbNMi1fg64C3Wpk6iK4lmGdzL8zqS+PATLzWtu+I7g4ClJYhQHDtu7
         Ywu+MOb0sj/ZdbtaMRlrUG4K1MkxPJxkCLhntzpZfZKtnuXaW4Jo6Kb3lt3uhl6/1E0N
         RxX/WMHcdlrDMltp9uhexvCqFZkNCYDcqawII9n2K4Qf8V5fS+aSp/FVdzI8AZvQp139
         BOv7+sBI/R4TGJUbuhnBQ4jjj/CKGNMdsfLNT+4BFtl721fDwNgkf68s2pK2MXd4QVVq
         3YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MQ3ZpAPeNHg1Ef0teanT2VmVPWPfDvQemS8HKBKQCAc=;
        b=S7IALLYyn1IBmG7u41g8BP6KPJ/Sist7moSR2FaPKPYQLI8ewbz0Ncty3EfkOcLFlL
         iTEU5a0h4/6pzTThQprUo1Nya9L4yQ29h/WWX934SddFbJwrc7wOdQ7fbCuGN2soS+Rz
         D4SddtEXwxERhP1uTSISWelUwqRov/qzMBIJi2mcWReZuI1gd3kxBy3rGZtJOepbh9dD
         aPuJfH4O6FFGm8l3SOzk9UmncQ4QkHqXn4MIzHm376QxYeSNVALx4+eXLeIm3YM/lo5T
         u3Ax11WbI9B3SB4seBwdm0qO8E30XA46Tcl4Fy74p4hd/AUNUKg2EPYnUAW2OU9uRbza
         v7ew==
X-Gm-Message-State: AJIora9yW0SQqxS2rAOGteXr1u+m6IBaT6M2fmpKFxX1IIbSrAJ5WAt7
        ZrNwFaOPy/shkxp9oUTEaVojdI8m6wDE6MtgCoe21UJIzI5NJyl5gYKg5vrCUNe6SVf5nsJAO8k
        l972z4XThJw8WwzCquo7z
X-Received: by 2002:a37:306:0:b0:6ae:f4e6:4218 with SMTP id 6-20020a370306000000b006aef4e64218mr9131958qkd.339.1656357886168;
        Mon, 27 Jun 2022 12:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tazZ5J/fYc/IsmfuWp1bLJtZosrTy28QW1yb5hmG2I5ssAQWqh6+gBfHhXSqodCdh14oCGRA==
X-Received: by 2002:a37:306:0:b0:6ae:f4e6:4218 with SMTP id 6-20020a370306000000b006aef4e64218mr9131940qkd.339.1656357885768;
        Mon, 27 Jun 2022 12:24:45 -0700 (PDT)
Received: from downhome (c-73-122-215-224.hsd1.ga.comcast.net. [73.122.215.224])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006a75a0ffc97sm9540450qko.3.2022.06.27.12.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:24:44 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
X-Google-Original-From: Rhett Aultman <rhett@samsara.com>
Date:   Mon, 27 Jun 2022 15:24:43 -0400 (EDT)
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
cc:     Rhett Aultman <rhett.aultman@samsara.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
In-Reply-To: <CAMZ6Rq+FSzy5ijQZhYyVJrbe86U9faD5aPFO4cezNkN9G-USzQ@mail.gmail.com>
Message-ID: <337d5316-82bb-e048-2014-b0634fadf8@samsara.com>
References: <20220610213335.3077375-2-rhett.aultman@samsara.com> <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de> <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com> <YrHM8mqG3WVVesk4@kroah.com> <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu> <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com> <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com> <YrLjsAOlsizMc/1c@kroah.com> <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com>
 <YrMJ0vXR84cISTse@kroah.com> <CAMZ6RqJZKYOTtLpiM3ie3fNOBm8i7d8yr8n7S=yAm6twbuhGrQ@mail.gmail.com> <99ac782c-46e7-bbef-8f54-cf2fd67acdc@samsara.com> <CAMZ6Rq+FSzy5ijQZhYyVJrbe86U9faD5aPFO4cezNkN9G-USzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-548675973-1656357884=:957070"
X-Proofpoint-GUID: czI3eyAu551jkwcNVFW6eEbAk_fPIW2R
X-Proofpoint-ORIG-GUID: czI3eyAu551jkwcNVFW6eEbAk_fPIW2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206270079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-548675973-1656357884=:957070
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 26 Jun 2022, Vincent MAILHOL wrote:

> On Thu. 23 Jun 2022 at 03:13, Rhett Aultman <rhett.aultman@samsara.com> wrote:

> > On Thu, 23 Jun 2022, Vincent MAILHOL wrote:

> > > On Wed. 22 Jun 2022 at 21:24, Greg Kroah-Hartman

> > > Yes, this would give a clear answer whether or not DMA was needed in
> > > the first place. But I do not own that gs_usb device to do the
> > > benchmark myself (and to be honest I do not have time to dedicate for
> > > this at the moment, maybe I will do it later on some other devices).
> > >
> > > Has anyone from the linux-can mailing list ever done such a benchmark?
> > > Else, is there anyone who would like to volunteer?
> >
> > I have access to a couple of gs_usb devices but I am afraid I have no
> > experience performing this sort of benchmarking and also would have to
> > squeeze it in as a weekend project or something similar.  That said, if
> > someone's willing to help step me through it, I can see if it's feasible
> > for me to do.
>
> I can throw a few hints which might be helpful.
>
> First, you should obviously prepare two versions of the gs_usb driver:
> one using usb_alloc_coherent() (the current one), the other using
> kmalloc() and compare the two.
>
> Right now, I can think of two relevant benchmarks: transmission
> latency and CPU load.
>
> For the transmission latency, I posted one on my tools:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dcan_20220626075317.746535-2D1-2Dmailhol.vincent-40wanadoo.fr_T_-23u&d=DwIFaQ&c=5cz3ZESzsFPW6Kn30oD8Yg&r=yZeJccB4JMhCRfLQXCMV_s56v3-BAi0tMrD3qzCwGTk&m=E5qqM5zYANpQqfZ0c8AHYrd-lkJZsS6-u-Jj2iTfHIjLle6JxCMRuTlmC_3bH8oA&s=sqvGqOvbtLqlZGMC-9q6gY1nF3203MT7gJIIqbKEXUM&e=
>
> For the CPU load, I suggest to put the bus on full load, for example using:
> | cangen -g0 -p1 can0
> (you might also want to play with other parameters such as the length using -L)
> Then use an existing tool to get the CPU load figures. I don't know
> for sure which tool is a good one to benchmark CPU usage in kernel
> land so you will have to research that part. If anyone has a
> suggestion…
>
> > That said, the gs_usb driver is mostly following along a very well
> > established pattern for writing USB CAN devices.  Both the pattern
> > followed that created the memory leak, as well as the pattern I followed
> > to resolve the memory leak, were also seen in the esd2 USB CAN driver as
> > well, and likely others are following suit.  So, I don't know that we'd
> > need to keep it specific to gs_usb to gain good information here.
>
> Yes, I looked at the log, the very first CAN USB driver is ems_usb and
> was using DMA memory from the beginning. From that point on, nearly
> all the drivers copied the trend (the only exception I am aware of is
> peak_usb).
>
> I agree that the scope is wider than the gs_can (thus my proposal to
> fix it at API level).

(removed the USB mailing list since this is CAN driver related
specifically)

I appreciate these pointers and I can look into making the time for this.
As I mentioned, I do have a gs_usb device (a Canable using the Candlelight
firmware) which can help shed some light on this question.  I do
understand the ideas being expressed in these pointers.  I do want to
bring up some practical matters around it.

First, it seems there's a pretty strong set of permutations to consider,
given that this memory allocation scheme is common to so many drivers.  I
only have a gs_usb device (a Canable using its CandleLight firmware).  I
also cannot rule out the possibility that the underlying hardware of the
host matters here.  For example, I discovered this leak in the first place
because I work with a specific ARM platform where it's easy to exhaust the
DMA memory.

Secondly, this sort of benchmarking work will require lab setup time and
my locating adequate free time in which to do it.  This isn't exactly
labor covered under the original mandate from my employer, so I'm going to
have to figure out how to work it in.

In light of this, while I remain committed to helping work the problem, I
can't help but wonder if it's worth it to consider my original patch in a
new light?  The code is less elegant than it otherwise could be, but it's
consistent with practices found in the other drivers and it does resolve
the original issue of leaking DMA memory.  I'd hate to see a long-standing
issue continue to languish because I struggle to find adequate time to
devote to the benchmarking needed to reach a decision about the USB API
changes we've proposed.

Best,
Rhett
--8323329-548675973-1656357884=:957070--
