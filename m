Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B057307A5
	for <lists+linux-can@lfdr.de>; Wed, 14 Jun 2023 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjFNSxk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Jun 2023 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjFNSxj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Jun 2023 14:53:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703F91A2
        for <linux-can@vger.kernel.org>; Wed, 14 Jun 2023 11:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLIpL9lc1rCwzbp9ZoZMXFx9wCkK0nUeoxiW6zuZmnQDaoZ+STUKuZd8cH9JziJpKm5KffxZIhY0GgUQ8l72GSw3hMnxfW4zo+JxCUFKI+pqv9/MkseYqsLfHuXxz2/ln6c6ocHgT/cLAXY/SGwHOYzJ3aczHigWrXagTReDdXYqGCx1RAcqmeLczVQaGWlNB5A889kva6bWEumJ5q2CTSnSW60VLbOP6XOKysJlOtGvFHzKYWnC4lk/n2Px2sM6aRTrZBzovRcR03AZzTr516wD4OJZKMJ/7YVybJqFh0WI2mAtZIHtW7Hxlq3QMyMImRtj7wB43hg1hkYFTzhpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDEnjrgJ5RtLRlxJHIAPjH1DMZ+CI+gzmYrC3c5Y/BM=;
 b=Lj/+8biexoRwIMKQ11Gxa3YlxLb4Ec/x0rvH1dL4DAPfb9Br5BgiqQgetLOyFVHw+cOtuz4KMING2x77WZlIp7/LRKxwr7XXEGZ4RLoOK6mixkvZJcH/D2ZZy+kUCVSEptjySBjZkp7yswWcmHo+JlUfouiTbWPSQBUpjzsIMUETHsPIBy84zXrvfqBly19rfEBgnJSLNQ9z4oeMi3UCcQk0sBWG2tMViTgqMrnFQUgKacwumer4wsuitGJcc44W2sRv7HsrjSPH57KchpOgy6yA1SDS0B+GzL5IZdh55kAtvYslEgJKBLlO5+HokyrhbKCuKa8riPLSADwD7da/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms.se; dmarc=pass action=none header.from=hms.se; dkim=pass
 header.d=hms.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms.se; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDEnjrgJ5RtLRlxJHIAPjH1DMZ+CI+gzmYrC3c5Y/BM=;
 b=h79e6nYM7KCArh9qY7MTtEd5SeTbxkHBS8/vEKYjHh0Nwwppxkz0W3hprYHbtgitrMsAS7O3q2dB5s4Fp0bW4ZZqDZ7DOoZSwF0yyUrTmFcCL10lmTVnzfp2dNvfdgjUrvMEz1blmWsfeXHhIjAilJeVs2RFaIcnTL9l1QSLNLk=
Received: from PAVPR10MB7209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:311::14)
 by AS2PR10MB6688.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 18:53:29 +0000
Received: from PAVPR10MB7209.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fb8:41fa:a2ba:6b25]) by PAVPR10MB7209.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fb8:41fa:a2ba:6b25%4]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 18:53:29 +0000
From:   HMS Incident Management <Incidentmanagement@hms.se>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "vincent.mailhol@gmail.com" <vincent.mailhol@gmail.com>
CC:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "fedor.ross@ifm.com" <fedor.ross@ifm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "wg@grandegger.com" <wg@grandegger.com>
Subject: Re: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Topic: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Index: AQHZnvGC/sB42lMn1UWafqWsjNjSbg==
Date:   Wed, 14 Jun 2023 18:53:29 +0000
Message-ID: <PAVPR10MB7209ECC514485BBF81898EA0B15AA@PAVPR10MB7209.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms.se;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR10MB7209:EE_|AS2PR10MB6688:EE_
x-ms-office365-filtering-correlation-id: 4bbd2a85-2f59-428b-70aa-08db6d08a4a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mSb+ih/2EQxU/UlgYnXtIhaAwBgTvWmyx+7FbnXzXhE8/3Wto99JZv0BqTjGb6BF8T8lYQYefEhLGmLOChztL421x5bxoaZsAjwt//xx/yi0O36TV+wIaP1UOgEO6uX+dghyaxcj0uCh2ujFVhHlFntCl+2p/O6CkGJFygcMXb0MBuCY0euRXxcRxAwrac6CNTgNEWnzGsUb79DGeggZdFXYiLhlJv+gj03tVgW+/Df8yi17qJiUx6VRXWh3DoBp5J3pN8hXsvUUV8Wu/E1loI8+zm6uz/eN2d78QzCo1NVUPzn6XYkM5p2QvIPPJaVtACpeOAu9+EWRnjxkF0ZWbsJk8O2OqgGexsO1hjMVnoqhMDnCn2nBpzR6EYLG79t5QZ9YNL3Ud40ubHrB/wdvd4ZnNj4hWWAk+w/tb/2dw4TpVyoOaoMSvPenpl0roQ8I/c78v89clxkUGXCZciN85c8cbSfws879M66Wm6kUezo5dem2TNVvqkoJJb+PVZm3FRBVvzTC+hNvJavugrDguzRFqK8I7ji4fTjMxyno5rCrioMFRZ2KzZEFrRuzwkP/R+jqchyvdbqYWRfO2Ez6cl//Q113HuThzS+f7sHWyEbWNZY4qxwhgw/ARs19fzX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR10MB7209.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39850400004)(136003)(396003)(451199021)(4744005)(5660300002)(7416002)(186003)(52536014)(9686003)(26005)(6506007)(53546011)(2906002)(71200400001)(8936002)(7696005)(8676002)(41300700001)(55016003)(66446008)(66946007)(38100700002)(122000001)(316002)(478600001)(54906003)(110136005)(66476007)(66556008)(64756008)(38070700005)(86362001)(33656002)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7PBnXBMykOu98PvZHjnX80JiBHK+2kmWenJ9J59TmwdxAWTbXrC/V8opln7l?=
 =?us-ascii?Q?Fihjyep9GILIsP62JVWvRViu6zhClsbCrkfkGe6o1nEtXTdRSEiLkqtnc38b?=
 =?us-ascii?Q?I1l3hcgzl5hVp6o5sFycA5JSTeTKAhPIHnWIktRcJe9FmE78ee4IXlcmCC5n?=
 =?us-ascii?Q?j/bTfcVQyanX6SVhgv82/ASsA0c5pnxGzTZuzitSpveuZCQi77uv5ifFtdoE?=
 =?us-ascii?Q?GDXxr4x/ex5n89vEAQxhdzxbjsifaM+G7oRsOsBMSg5bT3/Y/Pi8oMClSOBP?=
 =?us-ascii?Q?PbINCswSCoBG0cm+adKAOfkQZBDiK4sQviGHHBQ2JH/xyr02EeM7dXLu1dQd?=
 =?us-ascii?Q?jzgjdN7XKZ8wwqJKx03viIXDakUUVYc+kFgh6AWOGm6zl7xVob8PHeL1Nmu6?=
 =?us-ascii?Q?98q9EtW8kzldY0Spdz7E87lEs3ZWUadqMvK4VRbqxKMBZFxA+1uKlsYyurij?=
 =?us-ascii?Q?UzCBGZkhlj3GZbAN5HXU0Qu6RBOetFTEciiLbe596x5cTrjBPqpoA80HQ0m4?=
 =?us-ascii?Q?ZwBB9E/33cbP3Sz38X2YzKrfm0C/AaC4n8FOcXtFjsMSJoVNOxPeR4Z66IQO?=
 =?us-ascii?Q?2seGOfzCSJ4MF0ZYb60aGEnoxrRBV2dI+1EF0D7pb+pB4HRhcaLhJ1jeKWek?=
 =?us-ascii?Q?GCOTLTPCxxmgvDKJ3fqnNUP0Q3nOYDN0d18zq/vzLk8YdcFdejHdlJaS8C1D?=
 =?us-ascii?Q?BEgdadb9lV/OK5JfDPvKW7ehqqjPmUV699Sapw0ncyMp5oFLYcDB6jzLN5t1?=
 =?us-ascii?Q?DcQutFsjeLVJXpBEXEX5YhAFLx3fJz51PomZd2qzo7mx+gekBiWEn+hUaYW+?=
 =?us-ascii?Q?RKJnQtZ+JRr7GtW4zlZHoKP0lOs4KD0DjmbIIA6x32eG1akaEf9H4vvcqaFz?=
 =?us-ascii?Q?+w15AV2J72gomXf0/88jKEaq1V7u4GIe61zboemGmYUFjF9PySYIRFkam3kS?=
 =?us-ascii?Q?4s5RR+gWFUpMgOy9BC76kL+M0lmyR5agYPyE1BgD7OL2M6OTDDdTl5nNCix4?=
 =?us-ascii?Q?ZOXE6nbfIv7pfDiw31zO9bpYLED8/MsCkx/C8ABCQCfSSaLeyJgXwHude9w/?=
 =?us-ascii?Q?R8Jg2hk/qP4k56dOsR9BnPeEOyo7Xjxb7ZS/YAWhcothFwkr1M3pI5swp4+I?=
 =?us-ascii?Q?C1kwPfHXFSa9AbdORDlfGGLnWxBGBn92RRZ9I5NPEnlTwuXMc8uOhSHz9qQP?=
 =?us-ascii?Q?bJvYRHmL4scrFAfa4dxe7RzzLXnKJeV5C8Q0dPxcuGjCKRzxyFcxyyO4bDZf?=
 =?us-ascii?Q?n4wRS6ADh/gE0PbvQ0JPp/xAtZvcqDlq9vzUYHfvyWeP6BnN+wHv2bdYf83u?=
 =?us-ascii?Q?rKCppBSnYxXE5EeqJvfg/tRO6krlY9kLDTfYl29WkeQewoIwSgwLWX18Np+a?=
 =?us-ascii?Q?vn76xGOfYdyFWTAM1IK7RW+EHT2DjvBt/h3ndh3PSOHKUHThs/M4w3VtUz+u?=
 =?us-ascii?Q?7WDkvFmlfcNMZpH4Bdf/frBGBeqEKr8S16rhqMp+75GEsap4rU0B/NE7R4QC?=
 =?us-ascii?Q?vJQrjx124pDwcoYFWrXR0g/cLQw3AT0F8vVPd+wzepW8dRhJ+pDq39VtHOkg?=
 =?us-ascii?Q?fu48t9vXQzTGJn1Abp6aH90nAHpPrzTZ0Q26k7JqFmLX/XI5zh5CAjtcNns/?=
 =?us-ascii?Q?E2PwvvCA8MGQkTtvo98WnS8LhZjMYmZdWXlsP+jP+9Ck?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hms.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR10MB7209.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbd2a85-2f59-428b-70aa-08db6d08a4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 18:53:29.2000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnJbzHxFEFM3ZJrvL4BS24keXThCWrmmAiN+9pPfst9hkNDQYS46vS0LbU53/+sKT7qXvv6XV1mu0epiC16w4YF4GgWkltjW3SdF1wi1CwUVECFImiFF6R4c4PcoxtwHC2pQaY8n6w7122MVZJEWmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6688
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

**We apologize for the delay in delivering this email, which was caused by =
a mail incident that occurred over the weekend on June 10th. This email was=
 originally sent from marex@denx.de on 06/11/2023 12:15:50=20

On 5/17/23 09:15, Marc Kleine-Budde wrote:
> On 10.05.2023 20:19:38, Vincent Mailhol wrote:
> [...]
>> ISO 11898-1 is such a rabbit hole... sights...
>=20
> How do we proceed?
>=20
> I like Marek's approach of defining the delay first in the driver and
> then moving it to a common header in the second patch to facilitate
> backporting.
>=20
> Do we agree on the maximum number of bits to wait in the worst case?

Is any further change expected from me to this patch ?=
