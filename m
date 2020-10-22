Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A552956CB
	for <lists+linux-can@lfdr.de>; Thu, 22 Oct 2020 05:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443918AbgJVDbF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 23:31:05 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34287 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443889AbgJVDbF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2020 23:31:05 -0400
Received: by mail-yb1-f193.google.com with SMTP id o70so405302ybc.1
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2020 20:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opOkHwUpsXSKutuW6RPQw6tpQomOTtGr85bDnFVClds=;
        b=uCjGkC1R17WWp4Xei4offXdCnhhtKEPTLzARIVD6EK4qKCJkl5jP3KB6dLPIasFcaI
         fbbes72xm5wOr7ZDa8jfOKUoY+Yv5jJUdIsucbWGSUolo0CjE3JNfnYLWFbEC8TYZgPb
         j+TRRmhy4J56U9LlO1zagV7Rsq+7jI7GoaEfV9JD07oVR6upndH8BpwIj7wcE7SfxbCZ
         /w6WGDgnVUgWrUMc/45gONIYpaxbuN7Dy4BbsWNA2si9l/FqA0GxThQCDp/LHc5ottAz
         aS5Ar50xjfKlb0mbxCtl1jRn0rufQaUbbafGKQfkzJ+MfQC6Ij/gAXX52a+y58H+Gj4M
         QQIA==
X-Gm-Message-State: AOAM530DDWfs6xurUXYlgHUPHqM6Tkcj/PD+C/DzdQd3Tmpu1nlBxH7x
        i4K0LMQneJ7DOgC5e+l2C3zzIvQttTv0DMdoL6RazCThtkd2eA==
X-Google-Smtp-Source: ABdhPJxNlKVrMmP4FnjqM+8GA/SYmtgwCqyFkTuRBAvSx0oW7sAww9bu0zoEz9fX/vqUBOiYCnnm8q8K1iT03yAmRTo=
X-Received: by 2002:a25:d46:: with SMTP id 67mr554982ybn.360.1603337462512;
 Wed, 21 Oct 2020 20:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201019190524.1285319-1-mkl@pengutronix.de> <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net> <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr> <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr> <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr> <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net> <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
 <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net>
In-Reply-To: <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 22 Oct 2020 12:30:51 +0900
Message-ID: <CAMZ6RqJ8=T8CAhYaa8PZs5-d2zhx1_15wMe7ohUZovvqTcgW0w@mail.gmail.com>
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 21.10.21 02:52, Oliver Hartkopp wrote:
> On 21.10.20 13:55, Vincent MAILHOL wrote:
>>> On 21.10.20 18:48, Oliver Hartkopp wrote:
>
>>> To be more compatible to non raw dlc CAN frame sources the tx handling
>>> could also be like this:
>>>
>>> if ((can_dlc == CAN_MAX_DLEN) &&
>>>       (raw_dlc >= CAN_MAX_DLC && raw_dlc <= CAN_MAX_RAW_DLC))
>>> => use raw_dlc
>>>

In addition to that, we would have to decide what to do with malformed
frames. If can_dlc and can_raw are set to contradictory values, do we
drop the frame, do we just ignore the raw_dlc? For example, if can_dlc
is 8 but raw_dlc is 2, I think that we should drop.

If we go this direction, I would propose below logic:

 1. if raw_dlc equals can_dlc: nominal case.

 2. if can_dlc equals 8 and raw_dlc is greater than 8: use raw_dlc
    case, already covered in your code.

 3. if raw_dlc is 0, then consider it as unset: overwrite raw_dlc with
    can_dlc (so that it becomes case 1).

 4. Other scenarios: the frame is malformed: drop it.

Logic should apply for both Tx and Rx paths.

Then, the drivers/users would only have to manage scenarios 1 and 2
(and 2 can be ignored if CAN_CTRLMODE_RAW_DLC is not advertised).

>>
>> If I understand well, the idea would be not to use a setsockopt() but
>> instead rely on some logic on the can_dlc and raw_dlc to determine
>> which one to use.
>>
>> Unfortunately, this approach has one issue in the TX path that could
>> break existing applications.
>>
>> Consider below code (which I think is fairly realistic):
>>
>> void send_frame (int soc, canid_t can_id, char *data, size_t len)
>> {
>>      struct can_frame cf;
>>      size_t dlc = len > sizeof(cf.data) ? sizeof(cf.data) : len;
>>
>>      cf.can_id = can_id;
>>      cf.can_dlc = dlc;
>>      memcpy(cf.data, data, dlc);
>>
>>      write(soc, &cf, sizeof(cf));
>> }
>>
>> Here, the user did not initialize the can frame (cf) but assigned all
>> the relevant fields manually. Because cf is not initialized, the newly
>> introduced cf.dlc_raw field would have any of the values which was
>> present on the stack at the moment (rationale: the C standard does not
>> guarantee zero initialization). If 9 <= raw_dlc <= 15, the can frame
>> will be transmitted with a bad DLC value. If raw_dlc > 15, the can
>> frame will be discarded.
>
> No, this is not what I wrote. With my suggestion you need to populate
> both dlc elements to use the new "raw dlc" feature.
>
> if (can_dlc == 8) && (9 <= raw_dlc <= 15)
> => put raw_dlc value into the controller register
> else
> => put can_dlc value into the controller register
>
> When you have a test system to make security tests and you enable
> CAN_CTRLMODE_RAW_DLC on a specific CAN interface - which applications
> would you run to send CAN frames on this interface?
>
> I assume only the test application which is really aware of setting
> can_dlc and raw_dlc correctly.

My point is that this assumption is dangerous.

I do not think I made myself clear. I am speaking about old "non-DLC
aware" code running in CAN_CTRLMODE_RAW_DLC context.

Consider two applications: the first application is a test application
which is "DLC aware", the second is a legacy application which
contains the code which I presented in my previous message.

A user who wants to run both in parallel sets CAN_CTRLMODE_RAW_DLC at
netlink level. First application works fine, second application which
contains the legacy code gets impacted as explained previously and
stops behaving as intended.

Newly introduced option should not break existing code regardless
why. In opposition, we can introduce new rules if these are strictly
tied to the new option.

In my mind, imposing a rule that old code should not be used in
CAN_CTRLMODE_RAW_DLC context would create a huge pitfall and would
violate the "don't break userland" principle.

> CAN_CTRLMODE_RAW_DLC is no 'standard' option. It's a testing facility
> and only used, when people want to play with raw DLCs.
>
> An option could be to introduce a sockopt CAN_RAW_RAW_DLC that only
> forwards the raw_dlc element for classic CAN frames when enabled, and
> clears the raw_dlc field otherwise.
>
> But again: Who ever enables CAN_CTRLMODE_RAW_DLC has a specific use-case
> in mind and knows what he's doing.

Yes for the new code, no for the legacy code. This is why I think it
has to be managed at the application level, not only at netlink level.

>> I think that it is mandatory to have the application declare that it
>> wants to use raw DLCs (this way, we know that the code is "DLC
>> aware"). I can not think of any transparent approach.
>>
>> Next, we might think of using the netlink CAN_CTRLMODE_RAW_DLC and
>> the CAN_RAW_RAW_DLC socket option and the raw_dlc field. But I think
>> that this is overkill.
>>
>> If not introducing new dlc_raw field, the drawback, as you pointed
>> out, will be that we would lose the backward compatibility of
>> canfd_frame with can_frame and that can_dlc field can not be used
>> directly as a length.
>>
>> For userland, I think that this is acceptable because the very instant
>> the user calls setsockopt() with the CAN_RAW_RAW_DLC, he should be
>> aware of the consequences and should resign to use can_dlc field as a
>> plain length.
>
> Not filling can_dlc would cause tons of changes for sanity checks and
> feature switches.

I never spoke about "not filling can_dlc". My point is to not use it
as a length but use it as a DLC according to ISO definition. In my
approach, can_dlc should always be filled with the raw DLC value.

> Therefore everything should remain as-is and ONLY in the case of
> CAN_CTRLMODE_RAW_DLC and can_dlc == 8 the CAN driver validates the
> raw_dlc value element and uses it for transmission.
>
>> That of course means that this should be clearly
>> highlighted when updating the documentation. And users not interested
>> by this feature can continue to use it as they did before.
>>
>> Inside the kernel, all drivers advertising CAN_CTRLMODE_RAW_DLC will
>> also resign the right to use can_dlc as plain length.
>
> As explained before. This would cause effort without any need for the
> can_dlc handling.

With some relevant helper functions (can_get_raw_dlc(),
can_get_len()), I think that the effort for can_dlc handling would be
comparable to the effort for raw_dlc handling.

>> Drivers not
>> using it are safe with their existing code. Finally, the TX and RX
>> path would both need to be inspected in detail.
>
> Yep.
>
>> TLDR; socket options seem mandatory in all cases. We then have to
>> choose between breaking the can_dlc plain length property or
>> introducing a new raw_dlc field. My choice goes to the first option of
>> breaking the can_dlc plain length property.
>
> The 14 year old documentation in can.h says:
> @can_dlc: frame payload length in byte (0 .. 8)
>
> I will not break this established rule for a testing feature. The
> question from Joakim clearly showed: Don't touch this!

My point is this is an expert feature: if you do not understand it, do
not use it and you are safe to go using the 14 years old definition.

> At the end it would have made more sense to call it can_frame.len in the
> first place. But this first came into our mind when CAN FD showed up.
> The discussion about the can_dlc meaning can be closed IMO. It is a
> plain length from 0..8 which is unfortunately named can_dlc.

I agree that it should have been named len from the beginning, but as
a matter of fact it has been named "can_dlc". For me as a user, I
expect can_dlc to follow the DLC definition in ISO and so I *prefer*
to opt for the compromise of losing the plain length property rather
than losing the semantic meaning.

I would like to conclude by saying that I do necessarily think that
your approach of raw_dlc field is bad (if used in combination with the
setsockopt()). It has its pros and cons. However, if you ask me for
feedback, *my answer* is that *I prefer* to use can_dlc as a DLC. But
at the end of the day, I would be happy if the feature gets
implemented, regardless how, so that I can do my testing :-)


Yours sincerely,
Vincent Mailhol
