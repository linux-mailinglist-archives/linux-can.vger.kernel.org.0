Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD90FC141F
	for <lists+linux-can@lfdr.de>; Sun, 29 Sep 2019 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfI2Jtp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Sep 2019 05:49:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:16639 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfI2Jtp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2019 05:49:45 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Thomas.Kopp@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="Thomas.Kopp@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Thomas.Kopp@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: eZcj6pzeKbG8Gp6e/s75Y0TfXEr88nShhufu7GaoOs7GZS28r1BayAwgWgCf1EBLK/Ol+SnoeA
 QzJ6doNm96TjSbSEHl8K8nLEWNIRaV/fxEjAXPJ6rgKfSHt0ks2VGAUqgoffGzbB1R5GeXqUEI
 udOVJe3g/YDwxRX+M4fB76LZa+hQp4KYt2bWsvqTn6TC68RWlRFemVh0InPgTTXyVCnV8A4pEZ
 VYy7AGQyxrDMrUQy5HH94gpV7ychTSkDZQJnC85U8KdYs1yA9yLbMLHpdz2ZWIADGN7HFz9RzV
 mMI=
X-IronPort-AV: E=Sophos;i="5.64,562,1559545200"; 
   d="scan'208";a="52332834"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2019 02:49:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 29 Sep 2019 02:49:44 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 29 Sep 2019 02:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbecHfTSj+UKHXudP5XpGnwH9Omxvk/9TkY+ybpgHrzfR3NTYb5AzIVZm7gn2udY86x3t6EVJBeHIi7j+GoV5qF26bSYyKYrOA5GQPaH+hGY6WWzyFy6jMLEYsBlh31pI6zNxxTGfasloppmMljDk2/dejpeKCMdMLWzMhwpsdfpygWvaSwUW/CuH6USGGuQcksZPzaCZoKD3fJQQdErTOafBDI8h8trJPJfesHlvLAqMq9Tp7/ZYwX00MlR6uQHmT3v9d5ltx09P5GZRW9QcZS7GEzJZX2tNFzg8rD6ESeY8XUo5vghmpusAjSDCYIxD09S4ycADxkzjvLrnkI06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E0T40zv63tIizamiHogE762Apt0QtMEBJra0CNaM/M=;
 b=MQ+6AT4WFGymflofBvh0ecFzDiSc+ohjXuiWJU/NgLTAk8CZZN1IQo6dqz0rj+0zs1mAFPjv2At/tF9t1UsW7i6BmZN7aSKzAyQ9aY7u7sprAGfCGu2pBAP35GquPRJktzRz0HmyZkB/zsyx6mMrrs2Vim7QLAeCiNMbRcQItPZf8m9V/nhPnb/ObVpiTiSQRlnoAFBTfwEr9kCBiBczH1tvnGPIrnsqrxM2hJ+wc+x0NZtF/aBX+X0MQWbbD8irwzn5+BXYzja+JfjG2GESzzyizPd/uAZPDYLONEmwFnb+i276yp3vi0cWd1zMwMe0tEBlK2/Q2QdO6sp8Fa26xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E0T40zv63tIizamiHogE762Apt0QtMEBJra0CNaM/M=;
 b=s76QOdnzDCWzcE7RfvtHLEKeW7U77wxAfcpd7p/N0yNj3g9/m0D6UB+WJUPWtKfG1h4JZ8DqM6XxrYPobh8TifKoSnuOc/aYAQG4LYWN/RN0xXIEwezn9w4vAdKfz6GFWoudUQ2Sk+hALZCBbMSWSp2KTpaBm6fcxW+hxW2qClg=
Received: from DM6PR11MB3643.namprd11.prod.outlook.com (20.178.230.212) by
 DM6PR11MB3753.namprd11.prod.outlook.com (20.179.16.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Sun, 29 Sep 2019 09:49:40 +0000
Received: from DM6PR11MB3643.namprd11.prod.outlook.com
 ([fe80::64:15c4:519c:7a59]) by DM6PR11MB3643.namprd11.prod.outlook.com
 ([fe80::64:15c4:519c:7a59%3]) with mapi id 15.20.2305.017; Sun, 29 Sep 2019
 09:49:40 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <linux-can@vger.kernel.org>, <martin@sperl.org>
CC:     <mkl@pengutronix.de>
Subject: can: mcp25xxfd: Reset/Initialization of device
Thread-Topic: can: mcp25xxfd: Reset/Initialization of device
Thread-Index: AdV2plZaELxCvhdlRVKhsp0Qeb5yfg==
Date:   Sun, 29 Sep 2019 09:49:40 +0000
Message-ID: <DM6PR11MB36430CCBAE5F8DDFD4CA704DFB830@DM6PR11MB3643.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [37.49.108.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02f9a33b-98e9-4d96-92af-08d744c258f9
x-ms-traffictypediagnostic: DM6PR11MB3753:
x-microsoft-antispam-prvs: <DM6PR11MB3753F1FA68AF6057CAE5253BFB830@DM6PR11MB3753.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 017589626D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(366004)(136003)(346002)(189003)(199004)(52536014)(71200400001)(256004)(4326008)(7696005)(476003)(486006)(66066001)(86362001)(7736002)(305945005)(5660300002)(14454004)(74316002)(71190400001)(186003)(2501003)(26005)(102836004)(2906002)(33656002)(6436002)(478600001)(9686003)(55016002)(66446008)(66556008)(64756008)(110136005)(99286004)(316002)(3846002)(6116002)(8676002)(81156014)(81166006)(8936002)(6506007)(66946007)(66476007)(25786009)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3753;H:DM6PR11MB3643.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RVTSiK51xaAy5PUqgnyl3PcHBFZ01sOr8kUHfX0eV7PVIG93FqUFlXSu1TWQE/uR02ryWzyjBQ5Bq9z1oiKGlH60BZTN5a4f0M8KoYfM71VMSJfWfmHDHAGb0VguCb0kNpBNTtig1L6QJzgfVrMaOBBErqsYChRjU/rHR7j+UHm3nlTVGrRSrxDkpl/DgGb/r+UmMd6/mRr1ZO4TVkhVCPeuLi217U+0LaZzCcPQbXk/e0do8U2hAwEnOyUwGZg0loVEuVfWWS5K4ZNQm18y7AcphXEkiYd6M903R6QTX/CfHKFFlVpSc9Rth18Zi/rykDDWmOKh/r9f8lG1x08CLMyvspCayr3tj9Vlkv1TGWZntioOHEEpu7m5/XpBgO7r6R5GNKnn0JTyD0Mjg3VU9QB1PsAWq9gIXBwF1tl8SEo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f9a33b-98e9-4d96-92af-08d744c258f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2019 09:49:40.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMiazTcaoUbirofbdlr1wkyXIA2OrEYNcAQvLkubQ2TwnMLMJVflJAbZZdMAI9NoABKSuqfzWitn8IdnGcEhWrAFu06wstmBHPFbP3ozUNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3753
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

When testing the driver and using up/down multiple times on the CAN interfa=
ce I encountered errors with the TEF setup. I noticed that a device reset (=
spi command) is only performed when loading the module (in _mcp25xxfd_clock=
_probe during the initial clock setup.)=20
Is there a preference whether or not using up on the interface should bring=
 the device into a default state or is this only expected when loading the =
module? Are there any limits to how long up can/should take?

If a default state is desired after using up, I see two options to do this:
1) Perform the reset procedure the same way it is done during loading of th=
e module including setting up the clock again.
2) Bring all Registers to their default state "manually" and preserve whate=
ver clock was configured initially.

If 1) is used, stop can be simplified to perform a reset as well, no need t=
o care about resetting fifos etc. This is likely more time consuming though=
. Doing it this way is time consuming because we need to do the OSC setup a=
gain every time.

2) will usually be faster (assuming decent SPI speeds). The downside is, th=
at it's heavy on the SPI and we need to have default values for all the reg=
isters for each supported device.

Best Regards,
Thomas Kopp

