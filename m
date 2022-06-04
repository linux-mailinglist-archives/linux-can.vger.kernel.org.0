Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C888453D740
	for <lists+linux-can@lfdr.de>; Sat,  4 Jun 2022 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiFDOek (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 4 Jun 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiFDOej (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2022 10:34:39 -0400
X-Greylist: delayed 1580 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Jun 2022 07:34:38 PDT
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65E91A83B
        for <linux-can@vger.kernel.org>; Sat,  4 Jun 2022 07:34:38 -0700 (PDT)
Received: from pps.filterd (m0208801.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 254DwNO8017865
        for <linux-can@vger.kernel.org>; Sat, 4 Jun 2022 07:08:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : date : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=samsaracom06092020;
 bh=dHI3YNSkvKwIIvujjOjNRZNrK0eySEqgPiFXGTv9vfw=;
 b=vjdTXPKqlMtNomtLjnSt9XgtoZOe8INsGV8H3UdcoHiNDFQ7WoyjPHyFfhJ3k1wATAWe
 WTZu19gZCfjKlBedTe7zXsDmCefTDTCDjLSnEEpCiNm5wg/W3rX2bYcask282iWoUK6B
 h5oIewEOF+l/Cq4RPnHLNf3FPfGwvZ1WNuvuNnI/kAzCXAfQCUzovFHzTdHKwcIMGI5F
 wRpGF30puf2SeZoDh32JlEHCPmgo+e4xb+DgNp7lTASb8BcMxalPFsJ11lotjvdrmEl8
 h+UPbtOrAUu9LRgmn+HvKY9lvPHpSCNHAXMoxH3Ss4oBLnyK4yCJPNQHskCoNl2zoL8T Lg== 
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gg5mv026w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Sat, 04 Jun 2022 07:08:18 -0700
Received: by mail-qt1-f200.google.com with SMTP id u2-20020ac80502000000b002f94701339eso8048970qtg.13
        for <linux-can@vger.kernel.org>; Sat, 04 Jun 2022 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dHI3YNSkvKwIIvujjOjNRZNrK0eySEqgPiFXGTv9vfw=;
        b=daAA1wYqpeB51NCnFsL1uwxMmKKwYBAgTN1RkJhjOM56MMDBXSZ5Nps7YLb200Zv67
         ++8QFMy4+I5f/kRiFh432wyT8AyUWjfno4T+PITWzy5bOFSswPQfaepi4Q45Kuvb1mY4
         E2cd/iWL1bUt5sEMCskGL/N7LS5E1MuCjDjTekdyIMC8aH8aNHr0PyP+u01i9EzL8k2A
         uLLvUMx8cJK0uE76xFfcoZgtm/hvZ0D4a6Ihc6FWbnPdUt5ecpy4YjDANv9kJ1ORmd+s
         bNA4E3VXbTYWxTCInn+rwmzB5obgMtrBuxrcU/m7E0NLnZOvbQ4KJLcbsAHSrjeOEgaf
         EH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dHI3YNSkvKwIIvujjOjNRZNrK0eySEqgPiFXGTv9vfw=;
        b=QPG8Z/rNchUyKhfX16JmugmtFagk6NVzUlopccpYHA22EbqbW74HBinYb6jvTifvoD
         W1qkiFtnRVkZZmTHCoS6Dw6kKN/BqOmHioKIDLmyMsyBH3QKr6juX+q9sMnDt5HtKjjg
         hMpciDziJmOWFkPAxgH4VdZzvpSYSw121D0Rc+Jzbr7/MlHPz+aNjKRuB30lRdeNPczi
         d235n0a8KYJupVpUmo8339Ir49Uqs2DS6IFvaD4rFeReOdhgTc7reaXp+f74KGJfNGCX
         3RHiZwdVJqguAMn60TrqlZceNblSxnXaJAmEjPOyLnmreYpDw58QCtqgChieDbIwhzeI
         3vkg==
X-Gm-Message-State: AOAM530aG15Ne80R3jBh11ZdXtgm/gqQR/J/YO2lsSga9bJ0RukESZxc
        Q9ckYE0Spm0UXL3bIAstSzx7Gla5iQRg85H1tEfeO9lwK9HoWM1lDzgAIkaSGK2fsU09mtV6S2W
        Ughdh7fq9bzqkNrfky7Kw
X-Received: by 2002:ac8:5f14:0:b0:304:da72:cff4 with SMTP id x20-20020ac85f14000000b00304da72cff4mr8618183qta.2.1654351697184;
        Sat, 04 Jun 2022 07:08:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXGa/gEKKqiIEwvDdhwPgM10tRznyl4PENeamNUrpQUlZeNTHbk66rVc/rszT1AsZPfER7ug==
X-Received: by 2002:ac8:5f14:0:b0:304:da72:cff4 with SMTP id x20-20020ac85f14000000b00304da72cff4mr8618147qta.2.1654351696698;
        Sat, 04 Jun 2022 07:08:16 -0700 (PDT)
Received: from [192.168.1.10] ([162.250.128.47])
        by smtp.gmail.com with ESMTPSA id de41-20020a05620a372900b006a672209278sm5394897qkb.15.2022.06.04.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:08:15 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
X-Google-Original-From: Rhett Aultman <rhett@samsara.com>
Date:   Sat, 4 Jun 2022 10:08:14 -0400 (EDT)
X-X-Sender: rhett@thelappy
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
cc:     Rhett Aultman <rhett.aultman@samsara.com>, wg@grandegger.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb: gs_usb_open/close( ) fix memory leak
In-Reply-To: <CAMZ6RqJJbw6e8n=XRL7cn3P08XJFQCuVP83M2oGLjrrb-HWOfA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy> <20220604021145.55484-1-mailhol.vincent@wanadoo.fr> <CAMZ6RqJJbw6e8n=XRL7cn3P08XJFQCuVP83M2oGLjrrb-HWOfA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-ORIG-GUID: 61KNn7WbD6DIYRX3_PE9wrRAHOHaveBe
X-Proofpoint-GUID: 61KNn7WbD6DIYRX3_PE9wrRAHOHaveBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-04_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=581 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206040071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On Sat, 4 Jun 2022, Vincent MAILHOL wrote:

> > For me, the natural fix would be:
> >
> > diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> > index 33d62d7e3929..1460fdac0b18 100644
> > --- a/drivers/usb/core/urb.c
> > +++ b/drivers/usb/core/urb.c
> > @@ -22,6 +22,9 @@ static void urb_destroy(struct kref *kref)
> >
> >         if (urb->transfer_flags & URB_FREE_BUFFER)
> >                 kfree(urb->transfer_buffer);
> > +       else if (urb->transfer_flags & URB_FREE_COHERENT)
> > +               usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> > +                                 urb->transfer_buffer, urb->transfer_dma);
> >
> >         kfree(urb);
> >  }
> > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > index 200b7b79acb5..dfc348d56fed 100644
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -1328,6 +1328,7 @@ extern int usb_disabled(void);
> >  #define URB_NO_INTERRUPT       0x0080  /* HINT: no non-error interrupt
> >                                          * needed */
> >  #define URB_FREE_BUFFER                0x0100  /* Free transfer buffer with the URB */
> > +#define URB_FREE_COHERENT      0x0200  /* Free DMA memory of transfer buffer */
>
> #define URB_FREE_COHERENT      0x0400  /* Free DMA memory of transfer buffer */
>
> Obviously, the value 0x0200 is already taken by URB_DIR_IN just below.
> So 0x0400 seems more adequate.
> Sorry for the noise.

Now that you've pointed this out, I agree this appears to be the more
natural way to handle things.  I will take a point of making a rewrite
here.  Additionally, I'll do my best to bring all the other USB CAN
drivers in line with this.  My only concern in doing that is that I have
gs_usb devices to confirm the fix with but not devices for the other
drivers.

> > Maybe I missed something obvious, but if so, I would like to
> > understand what is wrong in above approach.

I don't think anything is wrong with the above approach.  I just happened
to see an issue in the gs_usb driver that was already fixed in the other
USB CAN drivers, and adapted the fix used in the other drivers to the
gs_usb one.  Doing so got your attention and you pointed out a more
general fix, so I agree with going this route.  I'll post a new patch this
week.

Best,
Rhett
