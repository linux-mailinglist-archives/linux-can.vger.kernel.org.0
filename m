Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611453BA21D
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhGBO3n (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhGBO3n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 10:29:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90DC061762
        for <linux-can@vger.kernel.org>; Fri,  2 Jul 2021 07:27:10 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id l26so8871636oic.7
        for <linux-can@vger.kernel.org>; Fri, 02 Jul 2021 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ryf7KKlLEZnGCFd3e8j8LiNLsT7TKCYDg8h06X7fOQ=;
        b=QEvn4FIxvpfGeA9gOvSA/rfiDXF7vnaz/lrxI1NXlZnmrS6pUD9+bXR6ID608sBE0F
         wsKUlTUuHplOE85voU5US/oN5ltEUcLyk/qZN8baE/qvVbXumhGjwpKkn5r1b18LFLbq
         /zzAcLyMgtn6WL8wcLVu1dy7BeG8C2RxQFMrZO8oIhaE/0GEsWAIyhR5HQoktglD+9vx
         1pZuBza6AyZ7nMmJr3yEcE2iO2lMFJZTFLYgz4cJGv49koFoOzTWbCDHTZ6UlwwQfMLD
         Akazuyz6pWUinNiIsL/OyHNwpsaZ6pvollLBPkfPLjd1AHCRl59mgzNNInoZDnTb5Iou
         UyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ryf7KKlLEZnGCFd3e8j8LiNLsT7TKCYDg8h06X7fOQ=;
        b=KE1uVuQ42EmG3in4pQ+beOVvwzEBx86vqbnAYc6ZvVcps1P9fF31CAiRXO2jyZ3eeH
         2JaJ27LHynzMsli3H46Wyd99CkFX48Or2DE6NJke/JVXnl/tv+JVvPzFedquPLWW0Ydv
         3WcttpPk9esA3hdqSTqbmGOzuygDi5TzZ4u6yrikkoONfbM+YMxzhdekq6yflcmNAYUD
         UPg7N9W865RuPY/6u6XDB06tYnoyCccf95l8gsdu54BRkqM7MA3e1YPnYJbFvcH2LQG3
         7JaGkHRBHrIQfnQxRY5cEvgTYsXM2Ki7w3m0HDUL9ESzicxPLGHA7I4LXnErRyEJ1TQQ
         CLOg==
X-Gm-Message-State: AOAM533EB0PZ23NTt1NfulHtCkjFviv7sscbHpzckm6Z9OEDms4Y8abb
        dI7KgV1KOBzl+SNi6gqYyAJwjtldn6QGWLAy9wA=
X-Google-Smtp-Source: ABdhPJxG30NWAzDGl+f+Txf0Splvst5XVekCZQ8LttpVnmAxYGGn3BknkZewWZ8KcMKiOSHuNk/9aDYfP/VNIBKrG+g=
X-Received: by 2002:aca:d6c2:: with SMTP id n185mr59813oig.51.1625236029575;
 Fri, 02 Jul 2021 07:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com> <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
 <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
 <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de> <029101d76855$fa5ac300$ef104900$@gmail.com>
 <20210625065626.b7afwhptoyoxoblx@pengutronix.de> <20210625121648.hg4hihfmddss7ptu@pengutronix.de>
 <020f01d769da$9fac86b0$df059410$@gmail.com> <022d01d769e2$e623cbf0$b26b63d0$@gmail.com>
 <20210702093110.vzfjk4dgovrrs4mj@pengutronix.de>
In-Reply-To: <20210702093110.vzfjk4dgovrrs4mj@pengutronix.de>
From:   Joshua Quesenberry <engnfrc@gmail.com>
Date:   Fri, 2 Jul 2021 10:26:57 -0400
Message-ID: <CAMGHUo=NK0Q=4y8Wgp3Mo+G8CuUcK8gLhxBH6Z1to8PZMZRr3w@mail.gmail.com>
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Patrick Menschel <menschel.p@posteo.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, Joshua Quesenberry <EngnFrc@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000038becc05c624c0ac"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

--00000000000038becc05c624c0ac
Content-Type: text/plain; charset="UTF-8"

The only other format I have is Saleae's trace format, if you're
willing to install their software, the attached trace should work. I
double checked that the application will load even without the device
attached, and it does, so it should work for you. I was using Logic 1,
but switched to their Logic 2 app and recollected a trace for you.
https://www.saleae.com/downloads/

Thanks,

Josh Q

On Fri, Jul 2, 2021 at 5:31 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 25.06.2021 12:55:26, Joshua Quesenberry wrote:
> > Forgive me, I forgot can0 = spi0.1 and can1 = spi0.0 right now because
> > I killed my UDEV rule so I was tapped onto the wrong CS line. Attached
> > is a snapshot of what I'm seeing AND an export of the data from Saleae
> > which may prove more useful than snapshots.
>
> Pulseview cannot parse the csv file correctly (see [1]). Can you save it
> in a different format?
>
> Marc
>
> [1] https://www.mail-archive.com/sigrok-devel@lists.sourceforge.net/msg03751.html
>
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--00000000000038becc05c624c0ac
Content-Type: application/octet-stream; 
	name="MCP251xFD - Not Working - 50 MHz, 500 M Samples - 20210702 1018.sal"
Content-Disposition: attachment; 
	filename="MCP251xFD - Not Working - 50 MHz, 500 M Samples - 20210702 1018.sal"
Content-Transfer-Encoding: base64
Content-ID: <f_kqmfj1ak0>
X-Attachment-Id: f_kqmfj1ak0

UEsDBBQACAAIAEty4lIAAAAAAAAAAAAAAAANAAAAZGlnaXRhbC0wLmJpbq3Y228UZRgG8Ge/6bZL
t92yFSglMRhJUFRaT4kmGrtV6mG3UQ4JqChVqXJJAngoirwmJtyIJzx7rXgG/QfAsygXhBs8n4kX
3hjPIoLfzDz7BrhYTfbZdvvOfDPzm53Z582X6cXLRsfHRscuKQCYjO+04v4DW0anfti2ZmNcW3x4
9voD/ftHgK3ppmNfNpivsdpPh0I6kBGxduRbUTt4dHNzjEPHl6aD8/Lxdj13xjWe0cFtGs+dzRrP
6OBpjefOGxrP6GCvxnPnoMYzOjiq8dyZnce+3TwbHZyr8dxpaDyjg1s1njv3ajyjg6c0njuvazyj
g480njvfazyjgyMaz52BbL5A2/1BB+doPHfqGs/oYFLjubNJ4xkdPKnx3Nmp8YwOPtR47nyn8YwO
/tF47sxKsgmp7f6gg7M1njtXaTyjg9Uaz517NJ7RwRMaz50dGs/oYI/Gc+dbjWd0cFjjuTMzf8Ro
uz/oYFjjuXOlxjM6uEXjuXO3xjM6eFzjufOaxjM6+EDjufONxjM6+FvjuTOj2Gr++DF/2sGKLSuS
QlKYNpR0d9Ym+wpJd9KVLFmQFPqGkvH5IRQvDI2lWVk+L1+7IITKcGgsCvFVGg7lYgi1ibgYQjkU
Qz3WMCe+B0JtWYhA+iqHUO+J9aK49ymlSnSq2c7x0HRbqIf4GeYms5KhpCP+dMVa6OxIP1dS74+n
qxYHQmM47hhK6eLJobY8nqoYKsXF8cxxYV517anZ5ijG31XnZ6PFarm6dm4xzAjl2t59nfn8zOs+
oYwcye/WfceOG28hhlreyvx7w3//q8OdKzSe0cHNGs+djRrP6OAxjefOqy29Z/kdrtnTFWMwpxST
uCHNRQxCfXUzTddmqZ+eDCa1qZ5C0htjV58Zd4pxXxiPypOapToGLj02zWr6txHb4AS0m+g165oL
MeJZaJfGLonk1SvzMp6VTc9MtIrirsHu7AKOjyIvGe+3vPT/H8Wm87XGMzo4pPHcOakzuxltz/J0
sFDjuXO5xjM6uEnjuTOl8YwOtmk8d17ReEYH72k8d77SeEYHf2k8d/q7NP1BB2dpPHfGNJ7RwYTG
c+cujWd08KjGc+dljWd08K7Gc+dLjWd08KfGc6da0vQHHZyp8dxZpPGMDlZpPHfu1HhGB49oPHde
0nhGB+9oPHe+0HhGB39oPHemT9P0Bx2cofHcuUzjGR3cqPHcuUPjGR08rPHceVHjGR28rfHc+Vzj
GR38rvHc6csfxtp+/qCDBRrPnUs1ntHBDRrPnds1ntHBQxrPnRc0ntHBWxrPnc80ntHBbxrPnUpZ
M3/Qwekaz51RjWd0sFLjubNB4xkdPKjx3Nmu8YwO3tR47nyq8YwOftV47vT2aPqDDk7TeO7UNJ7R
wfUaz531Gs/oYKvGc+d5jWd0sFvjufOJxjM6+EXjudPTq+kPOpiv8dwZ0XhGB9dpPHfWaTyjgwc0
njvPaTyjg10az52PNZ7Rwc8az51yRdEf/wJQSwcIttPDz2MEAADpLQAAUEsDBBQACAAIAEty4lIA
AAAAAAAAAAAAAAANAAAAZGlnaXRhbC0xLmJpbq3YR48UVxQF4ENBmTY9MzADBswKNjbJJC+xmG5g
jGFYICGEyMEEsSWaGcJdWGJDDg5ibYIN2OYPkDNsWJgMJokFG4QNBgyGnu4zRwSpsdSnpdZV3VJ/
r1TvHb2q/mJ8fmxDvmFYGwBzCt+Wim8vrMkvv7dlflPhaNzz7osu1J2vB9a1nHr9Ex+XjljjwbOk
pVEkCrVd6Sxyd1+ubu2x9WZpdfB5qV+pJ2esxws6mOfx5Kz2eEEHP3o8Ofs9XtDBWY8n567HCzp4
6fHkdC8t+0rXc9DBEI8np9HjBR3M9XhyVnm8oIMfPJ6c3z1e0MEZjyfnjscLOvjP48npVtwvUHE+
6GCwx5MzxuMFHczxeHJWerygg+89npzfPF7QwWmPJ+e2xws6eOHx5HRtW9yQKs4HHQzyeHJGe7yg
g689npwVHi/o4DuPJ+dXjxd0cMrjybnl8YIOnns8OR+VXjEqzgcdDPR4cr7yeEEHsz2enGaPF3Sw
zePJ2efxgg5Oejw5Nz1e0MG/Hk9Ol7Tc/jGr9LaDidtHpT2TXD5N0mxSkzSOT3vWpGmPJC000iRJ
M2lj23daEya80xqz4HWmeWjh113S3Ln79aWnRo72dgleJAaUvdjSncH7/0yQM8rjBR3M8nhymjxe
0MFWjydnb1mvF+dx/h/Dkty4TJJ2y06sKiyJTGHB1CbZ4rLJZFdtrC4/+RwEJ8oO9v8nv9X50+MF
HTzzeHI6f1C8fxXvXHTwmceT86XHCzqY6fHkLPd4QQdbPJ6cPR4v6OC4x5Nzw+MFHTz1eHLq2nvy
QQf9PZ6cBo8XdDDD48n5xuMFHWz2eHJ+8XhBB8c8npzrHi/o4InHk1Ob8eSDDvp5PDkjPV7QwXSP
J2eZxws62OTx5Pzs8YIOjno8Odc8XtDBPx5PTqcPPfmgg74eT84Ijxd0MM3jyVnq8YIONno8Obs9
XtDBEY8n56rHCzp47PHkdOzgyQcd9PF4coZ7vKCDqR5PzhKPF3SwwePJ2eXxgg4Oezw5Vzxe0MEj
jyenJuvJBx309nhy8h4v6GCKx5Oz2OMFHaz3eHJ2erygg0MeT85ljxd08LfHk1Nd5ckHHXzq8eTk
PF7QwWSPJ2eRxws6WOfx5OzweEEHBz2enEseL+jgL48np6rakw86+MTjyan3eEEHkzyenIUeL+hg
rceT85PHCzo44PHkXPR4QQcPPZ6cbI0jH68AUEsHCNUbz7uPAwAAvSwAAFBLAwQUAAgACABLcuJS
AAAAAAAAAAAAAAAADQAAAGRpZ2l0YWwtMi5iaW7t3FlsVHUUBvBTW9nXspV9b4EiIIT4QmZaoALT
FqmoBFQURcdHFRdAmTkPJsQEXMCNJ30RF9z1eQYVRZQYYowoLuPW8MCLuIEIM86955tz/0xIkdyT
MiG3hLm933z9zZ3T2e5whwUrm9tamltiVUS0vvjXW9Ijh7c2bzq6M7m5uLbidN2Gw7VfxIm2e2e5
XzxS1rDk305d5gU+UVzWyLnU1FlIlzJEZy9KDs2TPKynTpuNx3DoThtPnbSNx3Bol42nzjs2HsOh
gzaeOp02HsOhgo2nTp3c7MPenhkOzbXx1Gm18RgO3WHjqZOy8RgOPWfjqfO2jcdw6DMbT51fbTyG
Q3kbT50R/vMFhb5/wKErbTx1EjYew6H1Np46W2w8hkPP2njqvGXjMRz61MZT5xcbj+HQGRtPneHV
/hNS6PsHHJpj46mzzMZjOHS7jafOwzYew6FnbDx13rTxGA4dsPHU+dnGYzh02sZTZ5jsYoS+f8Ch
2TaeOkttPIZDt9l46jxk4zEcetrGU+cNG4/h0Cc2njo/2XgMh/618dQZenlXzx9DG2R3Z9XW1cV9
9qria7viqb+ske/01Fn3W/56qV9sOef7P3MB655SVS2XVBKrOhr9LdHLr6q+yOutmI1u0QVcwwud
yP/qJyptQolJ5/kVJRrOU+ju33FiUKVt0NhK26AelbZBPSttg2oqbYMG6EOUbNlFf6DqVWETWrGm
bIPKBhadG00gmkA0gWgC0QSiCUQTiCYQTSCaQDSBaALRBKIJXIITWDv/ErxS0Zsa0QSiCUQTiCYQ
TSCaQDSBaALRBKIJRBOIJhBNIJpA1xNoOnioul0OjTvnaXafHFa3zTk39rlk/YrHsHlf3iLzpWS7
kXl59ohk0+RIcb+X75Rsr5sdk6xDjpj1e4Xjkh1xsvwJye6RIwfFOyNZL1lIVt3Du3h63skKvSWb
Kwu5jIGycsDJ4iNl5ZaePuGfFJDlnCw7Cr1eQS89WrKck8XHoNc76BWQ5ZwsOxa9PkEvPQ6ek8XH
o9c36BWQ5ZwsOwG9fkEvPRGek8Unodc/6BWQ5ZwsOxm9AUEvPQWek8Wnojcw6BWQ5ZwsW4/eoKCX
boDnZPFp6A0OegVkOSfLTkevNuilZ8BzsngjekOCXgFZzsmyM9EbGvTSV8Bzsvgs9IYFvQKynJNl
Z6M3POil58BzslSTZMkR0vPuTrFmyY46WR5Zsi7oZRai52SpRfDw8VXfW4yek+WRJUc5Xgt6Tpa6
Gt7ooBdbgp6T5ZElxwS9zFL0nCy1DN7YoBdLoOdkeWTJcUEv04qek6Xa4I0PerF29Jwsjyw5Iehl
lqPnZKlr4E0MerEV6DlZHllyUtDLdKDnZKlr4U0OerGV6DlZHllyStDLXIeek6Wuhzc16MVuQM/J
8siS9UEvswo9JyPGcdQ0Sx49w37eQJ0lNh7DoXU2njqbbTyGQ0/ZeOq83qV3SH6VlDxQaccgJtaV
/ZNDdx/7XH55ieIni8/6U17o7vXECGyP93kE70/pONbSZnrr8r0si69//KZ7vvykJOfql7qeID9f
Srz1ki9ZovhCRz8i4UXdPZHyy2udKFdPT8sL3b2e6B1Mz/+u9CsrbWF3ry9vwy2ktF3dPZHyy2u/
q7QlWHb3RMovr6PSPnHQPr/CJtReX2EbtGXXVc4uiLxwcU43dsoO1A4nyxyTbEzxEc378hbHjkv2
HjIvP35Cshbsh3rZ0TOSfeVkG2tk5yuJ/VCvd3cfyU462Z5ayR4tPraWvtKjJKuTZ24/zk+W7AVk
3ia92yjZAjyHe8X4PMn2OxkxXgPQ/i5fC5Q24bz/F406P9p4DIdO2XjqDJEphH0tynAIO3JhPXWw
UxTWYzh0q831VWeTjcdwaKeNp85rNh7DoY9tPHVyNh7DoX9sPHVq5Z2p0Lc/ODTTxlOnxcZjOIR3
58JeX3U2Gm0fHNph46mzx8ZjOPSRjafODzYew6GTNp46g+Ud2bC3F4ZDjTaeOottPIZDa208dR60
8RgOPWnjqfOqjcdwaJ+Np873Nh7DoRM2njqD5IVv6PsHHJph46mzyMZjOHSzjafOAzYew6EnbDx1
XrHxGA59aOOp852Nx3DobxtPnYGyMxb6/gGHptt46iy08RgO3WTjqXO/jcdw6HEbT52XbTyGQx/Y
eOp8a+MxHPrLxlNngPzLc+j7BxyaZuOp02zjMRy60cZT5z4bj+HQYzaeOi/ZeAyH3rfx1Dli4zEc
+tPGU6e/HHER+v4BhxpsPHWabDyGQ2tsPHU22HgMh7bbeOrstvEYDu218dT5xsZjOPSHjadOP3mb
P/T9Aw7V23jqxG08hkOrbTx17rXxGA5ts/HUedHGYziUtfHU+drGYzj0u42nTl85wi7k/eM/UEsH
CLYNsHAABwAA/2AAAFBLAwQUAAgACABLcuJSAAAAAAAAAAAAAAAADQAAAGRpZ2l0YWwtMy5iaW6t
2NlvVVUUBvAPAUEmKVqgWBMTE2wZBEpSEmLsvZxWb7kNkPjQCQoqyqMJIKPIesD4IgLi1D9AxQEV
/gEQZYYXXso8KeHVOKFYwNN7vn7hxRvj/W6ys7LXSX5nn5y1su/Zz7yQb2vJtzw7BMDKdAxEbOt7
O7/x5u5Vm9LZkv7Ja/omnGkCtg9cuv8XNdmMMX6+/cBAokSkcVh2Fbkb97YO5phSKOUHHczN8pV6
cto8XtDBqx5PzlaPF3TQ6/Hk7Pd4QQenPJ6cGx4v6OCex5MzOSv7Sus56KDB48kperygg1c8npw3
PV7QwcceT84+jxd0cNLjyfnJ4wUd3PV4ciaV9gtU3B90MMfjyVno8YIOVno8OVs8XtDBRx5Pzrce
L+jghMeT86PHCzq44/HkTBxa2pAq7g86mO3x5LR6vKCDlz2enDc8XtDBhx5PzjceL+jguMeTc93j
BR30ezw51dknRsX9QQezPJ6cgscLOnjJ48nZ7PGCDj7weHK+9nhBB8c8npxrHi/o4G+PJ+fR4eX2
j1z2tYP2t2Y35xfPSVa0ViVdhaakozBvweOF+Ul34cl0NCTthdo0PyUdNen8iXRMSZYW63KH5y2s
z53eNin7U0jsvlDKB9eAp8uuJXtwlD0ryOhB53mPF3TwoseTs8njBR287/Hk7C3rNfI9rtpT3fNa
c1VhbfrWW5LOwvS0Oh5Lulob02qoTbrbepLu4uakc/GspL24KOkszk86tvTW/FtFlNDgnXG07Ar+
S0Vk9xl0rnq8oIPbHk/OIw9mz5+dmv3/0zI6mOnx5Dzn8YIOVng8ORs9XtDBbo8n5yuPF3RwxOPJ
ueLxgg7+8nhyJozw9AcdzPB4clo8XtDBco8nZ4PHCzp4z+PJ+dLjBR0c9nhyLnu8oIM/PZ6cqpGe
/qCD6R5PTrPHCzro8Xhy1nu8oINdHk/OFx4v6OAHjyfnkscLOrjl8eSMf8jTH3QwzePJSTxe0MEy
jydnnccLOtjp8eR87vGCDr73eHIueryggz88npyHR3n6gw7qPZ6cBR4v6GCpx5PzuscLOtjh8eTs
8XhBB4c8npwLHi/o4HePJ2fcaE9/0EGdx5OT93hBB90eT85ajxd08K7Hk/OZxws6+M7jyTnv8YIO
fvN4csaO8fQHHTzl8eTkPF7QQZfHk7PG4wUdbPd4cj71eEEHBz2enHMeL+jgV48nZ8xYT3/QwVSP
J6fJ4wUddHo8Oas9XtDBOx5PziceL+jggMeTc9bjBR384vHkjB7n6I9/AFBLBwjG766mvAMAALEs
AABQSwMEFAAIAAgAS3LiUgAAAAAAAAAAAAAAAAkAAABtZXRhLmpzb261W1tv27wZ/iuCdtNhUSae
dAiwiy5t0eBLlq7OejP0ghIpm6gsZZLcJF/Q/76XlHyS6cSM3QAtEkrvkQ9Fvgc++z9l06q68i8Q
PfMF77h/8ew3shKy+abkw6TjndRDpSy6j2Iq79RcTmQO758nCaUkTtIoigiOovTM7/qHX2TzRT3K
0r+IzxEOw4SGGP4xHFEZxL/O/Jzfd4tGfmnqaSPbVvOf88fLuixl3kmhZfgX9DyiLKFxSMP+h535
902dA4EUV1Unm58cRDz7mZwqMCA880FtTRcjHKUkjkDSXM7r5uk/QHGTmVdUC1I1D1VN/YuCl61c
KwTWNl0v/dlfVOpR/36jylK1Mq8rAZqiCDNMGEkoSkChouF5B/7j5fZr4TlOMAXO4BKQdMObH+Do
3tDlr/D0nisz+suoyltwylxWHbz43+9n/kxNZ9fypyzfA/+nPw0DPc43/nz287qsG//C/0v88X34
KfFhGlV7X/Knr1yoR3jwWT5yIXM1B3ed+RXXzvUnX67gj1Z2Hain5T2Dql2pH93cTvSzrq7LTt3r
Ad6Ct73bRXfmTUr+U3pXVS+GZ6UElxs3rrhpK7une83qcsarCoAAU97/9lX+b6GaDRqYwwW8GYIH
NjS4mtzaNLiqlgqALifWAG1pcFnW+Y8tFcyI9+7y+o+/Hi25axbyzB9Mx1uCP1bap1uS+yHv3WSy
tH4i9UI5Xo9h3gZFyJYiEzWtVKFyXnXeP5X29hoQhzngX4t5Jptr1Wri+l4vkx5ooqnvRf1Q3cnH
TsOrbjtvJM77BAujA5s7XgneCGPrkmwFzN4Pniq8bia9uebTbqidqc6rG6+UgN+dB6r1uoZX7Vx1
8MnxCi0P9FzhEeA40vPa8LEqqh2yo92aG/oFq3bFeRPp4NnWu4fFdad1KWQDRL/Lz0jP4460l/Xe
9QJ25oK1wSsx/ZwTZy7EwoU6c4FP8o4uzJkLs3CJnLnA/rSjS+zMBfbTHS7JLpfXltIarImFYbrL
8BXIpxYuKHRmg0IbnzcgGdn4uGMZ2cCM3NGMbHBG7nhGNkAjd0QjG6SRO6aRDdTIHdXIBmtkwfUr
MEQ2NCN3OCMbnrE7nrENz9gdz9iGZ+yOZ2zDM3bHM7bhGbvjWZ+Zdz5n2B3P2IZn7I5nbMMzdscz
tuEZu+MZ2/CM3fGMbXgm7ngmNjwTdzwTG56JO56JDc/EHc/EhmfijmdiwzNxxzOx4Zm445nY8Ezc
8UxseCbueCY2PBN3PBMbnqk7nqkNz9Qdz9SGZ+qOZ2rDM3XHM7XhmbrjmdrwTN3xTG14pu54pjY8
U3c8UxueqTueqQ3P1B3P1IZn5o5nZsMzc8czs+GZueOZ2fDM3PHMbHhm7nhmNjwzdzwzG56ZO56Z
Dc/MHc/MhmfmjmdmwzNzxzOz4Tlyx3Nkw3PkjufIhufIHc+RDc+RO54jG54jdzxHdCPVlGwl9PoE
Zp/Q/31Jpl4KJNeu6wfvYSYrT1U6RQ5J43eXX26vvX94oT2Zt3wK7+nkq/elLnmjuif99ip3thsc
rAR+hmz5HonoRYnoBYn7M3eDkjPebmdrdUCq2tcS44fmRj9ARcYDb37jpRJeXXm9WEhFCsjbe7oi
o/36+f1Lfu2frqzUKr/i1D1iIUmpyh25e71r5K69O5K737VDwvtaVb/TtYMUsEdqD7/vQaph+0rW
+WU82tlqcL6WqthYuVAOgYxxO6sfrio9F3emKHDR1w3arpF8flffyQZqS7oG1o8PNZe+slPVQl5B
aQaFIeR2gFlTP7STzXKPgqd+HDGeJAUKUiZkQBnFAc9IEUC9jtGokIwVDPSeSdAfcvXA7cxXrSln
ic9KCAmFt6GKMIgfCj1ANFSahhqQF8LQ8iFUiHIoLE6hNgdKlHLK8yd4PLD4oKaqM8UqIX+qXA4c
llUioziP8ijCURHIRCYB5SwOMskKMCEHtSOOizQ/keLoeMX74pJRPCSyEDLLgyiN44DmKQsyxEmA
KRZpgTKRSnwixTWfIz3eF6eM4hEWoF2UBqzIeEDjRAQpCnHAeJhnVKYZF+mJFCfHK94Xs4ziJBEF
QTQMJFSgA1rkIsgIAo+nMpcYxYIjjc1TYJwerzg1m7ZRHKU552FGApRI8LgE7XlWaMgjkhY5S7M8
O5HiepEfCRW2VjzklEchkwFJZQZLMkVBJsAOkeI84SELJTrV4oyOVzxaK45EWEQcFC/SBBSPZRSk
UOoPwjyMOBGCxCE/kcfj4xWP14pHOMvDmOGA4ggUL+I0yOBLE4TwVeGFKAqWn0rxw7/jum2hnoKd
O5/xvoehnk5yXsp1uwh0TUBPhW5vqKe6++S+brpL6IeAXpRlmwAcAPuvURoxmCRYGwTDVx9REnCB
cVDQlGURgd9z/d1+cVFvbZtL9O/sW4d//vfZC7HGYNTb7U2yNIph3whiKWGWUQZbNmzeQSoYEwnB
Gcr1V/NFew/cqA/fNvYZDEHR0QanOcCZkiQIkZngWAY8YiIoGIsI9BSlPNNr/xQGH77d7DMYorej
DcY8zkkahoGAIwycaCQNUh7TQBRpxDkqSEJOZfDh29Q+gyFtcrTBeZQWgqewhCVNA0pEEvAihBnG
OOEc4F5Q/ZE8xQwfvr3tMxjyO0cbHKIiI5Iw2Bb10Q82Q5hhmQaYUThJh5ko8KnW8OHb4j6DIRF1
tME0pjCVSAScYDjAFLCQeZImgUQCR6GUEHSc6uR1+Ha6z2DImL3Z4O9weup7GtchFjQmLgro6Jmo
P6VuPiRhjFev3UB4BpHP+wL2NtNwCNFeV9+bv6G9cug1hGCra9TcjF72/NfhFjzQlKu3YecUfeB0
16jpFASvor1lPx60WfZydd4AltYQoX1VphtStyNCL1QDIZ0/DIFLoIFR9mr2XO/qCSgKoeCZD6Hz
DymG6GzoWRSLhutOL9PqaNoyzyEChUZMDq2I4Xmo98LWtK+tKPWrb40G/Wmpunz2SZWguGYkTf/c
uidx2NaNdiAaPFuZHtMPJrLUFIMTruupyj1oDvWQXjz9keVKx8iExIwmmKVRAh2pLMVUHwn6F+76
PkdDDLSGVLUTNV+UgxuGTRfgwTNInnRKgi5gcN8PCbO6MaybMHuG6xBYQSuudp2BTv+ujpnv6ukU
Gtt0r6CumO8jA8+vJDuQ9UB1lkbeJg06j9+iJAD+LWTR28jit5ElI7LP0Mz4wBv5YZkjfGn2oKV6
y0InYjSGjBv1GDlu1GMAuVGPceRGPYaTG/UYVS9Rr7YSp0U6php72r60x1RjDx9GNfbsYVRjjx5G
NfbkYVSHLc+xNw5bnWMql8U5pnVZm2Nap6W5QzzGiwtC0Rg2TsRj9DgRj0HkRDzG0i4xHMFaPr8v
5VdILN9udpsP2eQLNtwjMR1my0E8jG4P2t5Ew6tbb0JC3PxsDcIVET24NWYTM1xs2XrPJgSu0Ozw
GwTrzP7y1DeDuzSzuhRbxss2b5TxBhwa0Dn2vsGtjtacGcToWbL3GTknf1s+BIFwh2b21MLVgHJ5
itKZFDhdra+TrA5iG6fD/acU46q9Rxjtn30PTfl130NiiigrUOhj1+ArfwMMy7G7pf/MeyPfrPz2
C3JuK4rhRGyuKwWwLJd3a/T1IqjV6dhGX6kaqjdw6KvLxVxfgng2kYa+0nMFJZQO7ln0p1fV9mWo
ZUnnQYluBmdt+FCp9oMs+KKEKkyft8qgjPeH1Ic6PtwH2uAFd6Ee83Ih5Kemnk8kb3JgM8wS3Fma
yztzzoRkml1iDAvuBYlrFlZB5syr8aDvU2lr90hB+kP4gpie3ipisGUz3NgjJHlZxorDfjF6ypc+
HmIrbZQF7avorDUu//dCmgIX4EAvzLooVtEapDo1Wx1d3QBvCNc0yy40//cxgLH+trgcAj+DvEyZ
emB/X2t/qFAoc5Pr/O8D3oPwHChfixR2qNCrVLCd7FDhV6lgH9mhIj3V91//B1BLBwjhp7IomQsA
AJQ4AABQSwECLQMUAAgACABLcuJSttPDz2MEAADpLQAADQAAAAAAAAAAACAAtoEAAAAAZGlnaXRh
bC0wLmJpblBLAQItAxQACAAIAEty4lLVG8+7jwMAAL0sAAANAAAAAAAAAAAAIAC2gZ4EAABkaWdp
dGFsLTEuYmluUEsBAi0DFAAIAAgAS3LiUrYNsHAABwAA/2AAAA0AAAAAAAAAAAAgALaBaAgAAGRp
Z2l0YWwtMi5iaW5QSwECLQMUAAgACABLcuJSxu+uprwDAACxLAAADQAAAAAAAAAAACAAtoGjDwAA
ZGlnaXRhbC0zLmJpblBLAQItAxQACAAIAEty4lLhp7IomQsAAJQ4AAAJAAAAAAAAAAAAIAC2gZoT
AABtZXRhLmpzb25QSwUGAAAAAAUABQAjAQAAah8AAAAA
--00000000000038becc05c624c0ac--
