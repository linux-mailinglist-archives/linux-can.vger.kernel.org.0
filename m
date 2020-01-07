Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A58132C58
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2020 17:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgAGQ6k (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jan 2020 11:58:40 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42843 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgAGQ6k (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jan 2020 11:58:40 -0500
Received: by mail-lj1-f178.google.com with SMTP id y4so281785ljj.9
        for <linux-can@vger.kernel.org>; Tue, 07 Jan 2020 08:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcHVXbzZHaYT75JWa1AxDTwRpF3rFPLsDWCfjONGUTk=;
        b=UT6vgUi45yZE/mTanLQUaVsJfZQElryk3WxyjmR0rsorCUS3pV2EntWNN57uV1z4yr
         nQXZMNrr9BTTeqXqjDZbW1BRTJAst3vzMwBToKmW90WOX84kbFHpCkDrCc3M+5Rep4n4
         pI+HT9FcgcL1XHoDVZfkA73YnSG5IyzWaN1qK1LWOIkKDXPavKhONNDnqLEJPEVS01hA
         w50cEuu/KKCnaLbB7DFU+Fa1nzNM/hnUUo6/x/tS/Bf/VrURWHB+LoPAwORy0lGVkUEX
         HqS8rv6vsJ7RrAXY/Cb4bGEhzeDN0HlYWvqR+gfpJwHdaW9yMi8ziseR9QXpzWcyXR+R
         Xxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcHVXbzZHaYT75JWa1AxDTwRpF3rFPLsDWCfjONGUTk=;
        b=qxSnhpwFhBn4PCFuD4MQkEpEISwS3gpXhdVPuCQjKPeL5q7I25Umt9IXpFycgWJ2Vi
         NIHkQqzPlTdOvmkKP1POOo3328XdjmLOup5+PfQNVfytrTF70kmgTv0NS7B+nwLQ33O8
         Y6bY1U/NGudE50We3NsETGMVgAdA97x9KoCJ5C8WgWJxG1S/V2YBSi5IjJnxnwmsQXZi
         zH8oxpx9HT3DD/1lh1O8hyS1j7WSut2jcVI59BBhLqC+4uAAlssxIU2THyhseHzWIj6m
         XiSiGf5UYtIMslf51LrCnm6hAaZ25ZX5rHGl/U9w6RGtso+2H5wyBNEHMfhj7rfRFDJP
         15wQ==
X-Gm-Message-State: APjAAAWlOCUMnn+ig2zyhnYB8VTT0v3wn39xiut3Y8oKGJrM2wlGPkc6
        ZR/2FyxEDbjMIKW/g9RuC2HyxW0gbsx2bwK9sBuP3w==
X-Google-Smtp-Source: APXvYqxPuV9+XD4Wih9PeZVW/u0H+eed0af1zR2YuhJ/IX8EQ542SQ5ecBYOySkn897LHCDwrwJjEpHOy4BDCu1T14Q=
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr299037ljh.50.1578416318050;
 Tue, 07 Jan 2020 08:58:38 -0800 (PST)
MIME-Version: 1.0
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de> <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
In-Reply-To: <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Tue, 7 Jan 2020 10:58:26 -0600
Message-ID: <CAHChkrviSWcA0KS6jrzfPgE0ygs3tup1GseOeLto6OvLOgH2iw@mail.gmail.com>
Subject: Re: [RFC v3] c_can: improve latency and avoid packet loss
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,
I've been testing version 4 of this patch series on our product and it
looks good so far (only 1 packet loss at the beginning of each tests
after hours of run, which is insignificant). On my end, the 64 message
objects plus setting the TI chip's CPU frequency scaling/governor to
'performance' (from ondemand which apparently had issues)  made a huge
difference.

I'm assuming there is no other way to make the RX/TX split configurable?

Thanks,
Elenita

On Tue, Dec 17, 2019 at 9:25 AM Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
> Hey,
>
> V3 is the 2nd attempt to omit KConfig values.
> patches 1..8 are still identical.
>
> I changed the order of 9,10,11 patches since V2
> so that I never need any KConfig values.
>
> Still open for remarks.
>
> Kurt
>
