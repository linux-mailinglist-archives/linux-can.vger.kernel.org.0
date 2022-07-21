Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D585257C296
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 05:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiGUDNo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jul 2022 23:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUDNn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2022 23:13:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2B634B
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 20:13:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 75so710685ybf.4
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 20:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+9+RFlEWOgZsW3So8+RJ4LUckw1kMSGVEGJMF5NTMM=;
        b=C5mrlIYu0bbZhMkCBrVrcwzhRrzmroL31Sy869y9owsFAVhDi1rbc8KtmdUQGkttMr
         Cl9yXSaVxWU6Sy6GWZy+H91aS43ZZU0aIAe5rRQophafRSI4QId4qJPQArw2Nfaw/wCG
         OFZKNb1sVHP7Q8lAgWn42XpaKf53tRTp0U1Sfiq/zrBRmz2vHH3QA4HrLeIe2Mnllqs4
         NA/K620lPYJbvsUusSnnbcxEvZ6Pa70m89loNVXNgs+4SDarV66ZCHYeViKWI1Q4Ot8R
         ZOmbeX02LvrIlbOAo+FsR/UYOuVbN789mefJ8fj9eaDzcoX/n6WBESdYASSLEAV1XgMN
         UykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+9+RFlEWOgZsW3So8+RJ4LUckw1kMSGVEGJMF5NTMM=;
        b=a4zMdElH4ZH7yAntJOfWZ8LlFnvJzave0HlvbhOMqJ5dy3TLbK48u7WvYaEa8vyXwl
         FLDZkczy0K/D6SMSt6wDhkTgZPZgXbaN8wvfCz+oW05M2OCpDiFt38Vsml0S/uQsq1gO
         /fqvFxnfnQ7lwHKdA0GvVZ4Qe+xD0IO4AW/d8ARldBFShZepDkUPxixahVOD9Ss4m9kI
         4l3D9Lrg16WWtB2ITNTycMWtxlDVapfgc0vp4UPzsdyQbIrvkT8+EcKIHTG+EoCNI/eP
         xC/py9xQo8iG1HqmtBVdpKlFfqoyMjBq7lIFbb4Sb+hgsH6lnd15UG5qqxZvqHyrixrx
         EE7A==
X-Gm-Message-State: AJIora8Lqb5Yj9NPVPIgtYn2xYzujKf2ERK9DofOxSpp+uKtbK+siWOJ
        m8yCif4zFzEV8It9ERZNL/zX7rQNMcp4tcFbZR+XNcsdkdA=
X-Google-Smtp-Source: AGRyM1s3ho+5gH8Pq4AQ8JahF7lYxuT93DZnMItMNYZ4MH+bgNSIeqzn/TEJFxq5C6rhUtwBCrc9YzIMDwekq6D3VNo=
X-Received: by 2002:a25:a0cf:0:b0:66f:f075:51cb with SMTP id
 i15-20020a25a0cf000000b0066ff07551cbmr27100676ybm.142.1658373220722; Wed, 20
 Jul 2022 20:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220719112748.3281-1-socketcan@hartkopp.net> <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net> <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 21 Jul 2022 12:13:54 +0900
Message-ID: <CAMZ6RqKex6DwpFrs6pYe5UnSSHhu6TCcGi4xW1WcpKM8F=oS=A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 21 juil. 2022 at 11:37, Vincent Mailhol
<vincent.mailhol@gmail.com> wrote:
> On Wed. 21 Jul. 2022 at 01:43, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > On 19.07.22 17:16, Vincent Mailhol wrote:
> > > On Tue 19 Jul. 2022 at 23:38, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > >> No confusion.
> > >>
> > >> The API to the user space is 'truncated' option only.
> > >>
> > >> The data structure inside the kernel sizeof(struct can[|fd|xl]_frame).
> > >>
> > >> See:
> > >> https://lore.kernel.org/linux-can/4c79233f-1301-d5c7-7698-38d39d8702aa@hartkopp.net/
> > >>
> > >> ---8<---
> > >>
> > >> As the sk_buffs are only allocated once and are not copied inside the
> > >> kernel there should be no remarkable drawbacks whether we allocate
> > >> CAN_MTU skbs or CANXL_MTU skbs.
> > >>
> > >> AFAICS both skbs will fit into a single page.
> > >
> > > This is true. A page is at least 4k. So the 2k + alpha will easily fit.
> > > But the page is not the smallest chunk that can return malloc, c.f.
> > > KMALLOC_MIN_SIZE:
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/slab.h#L279
> > >
> > > Also, more than the page size, my concern are the cache misses,
> > > especially when memsetting to zero the full canxl frame. As far as I
> > > understand, cloning an skb does not copy the payload (only increment a
> > > reference to it) so the echo_skb thing should not be impacted.
> > > That said, I am not able to tell whether or not this will have a
> > > noticeable impact (I have some feeling it might but can not assert
> > > it). If this looks good for the people who have the expertise in
> > > kernel performances, then I am fine.
> >
> > The more I think about our discussion and your remark that we were
> > somehow going back to the V2 patch set the more I wonder if this would
> > be a good idea.
>
> I quite liked v2. My comments on the v2 were mostly to argue on the
> data[CANXL_MAX_DLEN] vs the flexible member array, but aside from
> that, it looked pretty good.
>
> > IMO using the struct canxl_frame (including 2048 byte) and allowing
> > truncated sizes can be handled inside the kernel safely.
> >
> > And with V2 we only allocate the needed size for the sk_buff - without
> > any memsetting.
> >
> > When user space gets a truncated frame -> fine
> >
> > When the user forges some CAN XL frame where the length value does not
> > match the spec and the size does not fit the length -> -EINVAL
> >
> > So there is no uninitialized data also.
>
> So basically, forcing the truncation everywhere (TX, RX both userland
> and kernel), correct? i.e. the skb length shall always be equal to
> CANXL_HEADER_SIZE + canxl_frame::len.
>
> I think this is good. As I stated before, getting -EINVAL is benign.
> If developers are doing crazy things because they did not read the
> doc, it is better to fail them early. If we go for truncation then
> always truncating is the safest: less option -> less confusion.
>
> > And even the user space side to handle a mix of CAN frame types is
> > pretty simple IMO:
> >
> > union {
> >          struct can_frame cc;
> >          struct canfd_frame fd;
> >          struct canxl_frame xl;
> > } can;
>
> Do you want to add this union in the kernel uapi or is it just a
> userland example?

More brainstorming. If we want to introduce a generic can structure in
linux/can.h, we could  do:

struct canxl_frame {
        canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
        __u8    xl_flags; /* additional flags for CAN XL */
        __u8    fd_flags; /* CAN(-FD) flags */
        __u16   len;   /* frame payload length in byte */
        __u32   af;    /* acceptance field */
        __u8    sdt;   /* SDU (service data unit) type */
        __u8    __res0;  /* reserved / padding */
        __u8    __res1;  /* reserved / padding */
        __u8    __res2;  /* reserved / padding */
        __u8    data[CANXL_MAX_DLEN] __attribute__((aligned(8)));
};

union can_generic_frame {
         struct {
                union {
                       canid_t can_id;
                       canid_t prio;
                };
                union {
                        __u16 type;
                         struct {
                                __u8 xl_flags;
                                __u8 fd_flags;
                        } __attribute__((packed));
                } __attribute__((packed));
         };
         struct can_frame cc;
         struct canfd_frame fd;
         struct canxl_frame xl;
};

#define CANXL_XLF 0x80 /* apply to canxl_frame::xl_flags */

#define CAN_TYPE_CC 0
#ifdef __LITTLE_ENDIAN
#define CAN_TYPE_FD (CANFD_FDF << 8)
#define CAN_TYPE_XL (CANXL_XLF)
#else /* __BIG_ENDIAN */
#define CAN_TYPE_FD (CANFD_FDF)
#define CAN_TYPE_XL (CANXL_XLF << 8)
#endif

#define CAN_TYPE_MASK (CAN_TYPE_FD | CAN_TYPE_XL)

Because can_generic_frame::type overlaps with the can(fd)_frame::len,
it will contain garbage and thus it is necessary to mask it with
CAN_TYPE_MASK.
The CANFD_FDF is only set in the rx path. In the tx path it is simply
ignored. This done, we can use it as below when *receiving* can
frames:

int foo()
{
  union can_generic_frame can;

  /* receive a frame */

  switch (can.type & CAN_TYPE_MASK) {
  case CAN_TYPE_CC:
    printf("Received classical CAN Frame\n");
    break;

  case CAN_TYPE_FD:
    printf("Received CAN FD Frame\n");
    break;

  case CAN_TYPE_XL:
    printf("Received CAN XL Frame\n");
    break;

  default:
    fprintf(stderr, "Unknown type: %x\n", can.type & CAN_TYPE_MASK);
  }

  return EXIT_SUCCESS;
}


Yours sincerely,
Vincent Mailhol
