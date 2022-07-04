Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC435659F7
	for <lists+linux-can@lfdr.de>; Mon,  4 Jul 2022 17:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiGDPgJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Jul 2022 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiGDPf6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2022 11:35:58 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EB2BE1A
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 08:35:57 -0700 (PDT)
Received: from pps.filterd (m0208802.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264FMmnt005605
        for <linux-can@vger.kernel.org>; Mon, 4 Jul 2022 08:35:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : date : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=samsaracom06092020;
 bh=6/cMnUUh1ad4Qp3G4u2tp66kHhAL7wJCigHkcts3ja8=;
 b=Wr9jVNyKom2IBp3FK0nFuZz21a59a6Tegc3SmAjW0npQcwxhzf1EwOfLPIwisTdTSADg
 epDBlWqiezup5l3i8QD0CazYJQFqMs2BNHMn7J4rEbUVYMQe4XLnaRaDvDFq1/MWXmSe
 b6D8idGp/WjTaZWolW2yZjDcHHwdRUxTv8wHJCl19gKbgHWo858vywSZ9RL3RUkSpwKO
 hayzHPlJumoN4nGHjJuzV+QcZpeWIXOAAsWjp5ONsjvHDlssUXBAaG5V2CIMjwbOPL6r
 2iM+h6w8OZKdKupdd++c1YJQboE9Sed4whKQEKvB5vNM93YmefH1YkTYQ3Dj3xgwhNVI zA== 
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3h2kq29130-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Mon, 04 Jul 2022 08:35:56 -0700
Received: by mail-qt1-f199.google.com with SMTP id cf8-20020a05622a400800b0031e80dcf14cso604187qtb.3
        for <linux-can@vger.kernel.org>; Mon, 04 Jul 2022 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6/cMnUUh1ad4Qp3G4u2tp66kHhAL7wJCigHkcts3ja8=;
        b=P1kJtfYJEPIfcjBjtDGEvOQC5yt/VvdwJ4uD1VJRaxXQfXOuiFRJM46XQNl1iw/xBx
         3aqg9l4HW835uO7VWdQUj1AMR0iY3plfv+VkJ++emEvqVcDo5MVnWbAtheCTvNAY7HrX
         JMQEB3ioy2/GBrUv4l59vgEMivxciRH7to5ev/qsUBEOr19Oo7U16JhEiQyKXIeWIRaF
         O+sNWI15lbhjxQJaAbQ/vzG5faziA+AxomGIKTx+33jSguAR+G30BJAHAJW3i6QzZ59A
         BOdVtcCua/4xths/va+mrE4cPFULyM4ZuoNKTHvmJUKDSGS4cliPnjMzUEivvQNuwfta
         dr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6/cMnUUh1ad4Qp3G4u2tp66kHhAL7wJCigHkcts3ja8=;
        b=iBQT0p9GJfz3rb1L3II280Xni5l/q6+djYTIgpT3N1tLoCBZlPsX6uRIu+LCj6zjt+
         FY/ttzHFtq7dNFfB/Cmm904SBc4hwv8rv5KVd0vblFVFGFT4v+jnpQOHUWCIhbS1tU99
         Is/EmcGx6XG3/jj61sOjXu/Ba15EMuUVhpBtKh2uolKIxuj7toku7TLoZ4MTG/niezB2
         xGPS4/sOpwZi/GI6iZLWbcBu1RT+4L5rwifmQBkzCSoIuEHGXCR1IpZSv0aSd0rHNzzu
         BxyaOhRbEMqhaNZvThVNP9Ycc/ravn+BEnUANaaoqMUSICp/IX1O/jrDYOG/vvYkhbI2
         FDog==
X-Gm-Message-State: AJIora+SNNVO9N4UJGaw00jIBR9sCtMLK1LlAKLsiUYtvOx8zUNbHe3k
        cUju9FzCnVeKYSJCQzncF2ZNwsEk5QjARYPQ5bG+WDgQWpLszcPLxWne7fZJOoqWOB6AZ5GmubZ
        q51bhdsRNxxDJbsZbD3mk
X-Received: by 2002:a05:620a:240a:b0:6af:27bc:66dc with SMTP id d10-20020a05620a240a00b006af27bc66dcmr20249870qkn.92.1656948955512;
        Mon, 04 Jul 2022 08:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sS4K6RW2GAQGKqx1kGmIQSOBGnSVLgCEQ0jDsPQy4x+6+1JXQnRrinlk91N/v6nLIZOjeXYg==
X-Received: by 2002:a05:620a:240a:b0:6af:27bc:66dc with SMTP id d10-20020a05620a240a00b006af27bc66dcmr20249847qkn.92.1656948955191;
        Mon, 04 Jul 2022 08:35:55 -0700 (PDT)
Received: from [192.168.1.10] ([162.250.128.47])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a290e00b006b46ad28ba7sm1750073qkp.84.2022.07.04.08.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:35:54 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
X-Google-Original-From: Rhett Aultman <rhett@samsara.com>
Date:   Mon, 4 Jul 2022 11:35:52 -0400 (EDT)
X-X-Sender: rhett@thelappy
To:     Marc Kleine-Budde <mkl@pengutronix.de>
cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
In-Reply-To: <20220704130249.lqpqstjxaz2773zp@pengutronix.de>
Message-ID: <alpine.DEB.2.22.394.2207041133330.535975@thelappy>
References: <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com> <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com> <YrLjsAOlsizMc/1c@kroah.com> <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com> <YrMJ0vXR84cISTse@kroah.com>
 <CAMZ6RqJZKYOTtLpiM3ie3fNOBm8i7d8yr8n7S=yAm6twbuhGrQ@mail.gmail.com> <99ac782c-46e7-bbef-8f54-cf2fd67acdc@samsara.com> <CAMZ6Rq+FSzy5ijQZhYyVJrbe86U9faD5aPFO4cezNkN9G-USzQ@mail.gmail.com> <337d5316-82bb-e048-2014-b0634fadf8@samsara.com>
 <CAMZ6Rq+hPC4N=_jGioUyaG0ezTE2qM8gDZic3ETESm0P=vkU9Q@mail.gmail.com> <20220704130249.lqpqstjxaz2773zp@pengutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-ORIG-GUID: oqTyQA0Z4ZiS6Jx-eAfL066MXa_Q19Wi
X-Proofpoint-GUID: oqTyQA0Z4ZiS6Jx-eAfL066MXa_Q19Wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_15,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=527 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On Mon, 4 Jul 2022, Marc Kleine-Budde wrote:

> On 28.06.2022 10:09:16, Vincent MAILHOL wrote:
> > > In light of this, while I remain committed to helping work the problem, I
> > > can't help but wonder if it's worth it to consider my original patch in a
> > > new light?
> >
> > Yes, it makes sense to take your initial patch.
>
> done

Thanks.  At this point, is there anything more needed from me on that
patch?  Addition of Reviewed-by: lines or similar?

> > I will reiterate that
> > I do not like the way it is done but you are fixing a memory leak and
> > delaying the fix furthermore is not good.

As an addendum, I think I might have found a way to scare up resources
and time for that benchmarking work, so while I don't want to start making
promises, there's a reasonable chance we might be able to do this in the
next few weeks.

Best,
Rhett
